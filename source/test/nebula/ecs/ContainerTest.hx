package nebula.ecs;

import nebula.ecs.Container;
import nebula.ecs.Entity;
import nebula.ecs.system.AbstractSystem;

using noor.Assert;

class ContainerTest
{
    @Test
    public function constructorCreatesEmptyCollections()
    {
        var container = new Container();
        Assert.that(container.entities.length, Is.equalTo(0));
        Assert.that(container.systems.length, Is.equalTo(0));
    }
    
    @Test
    public function constructorSetsInstance()
    {
        var c1 = new Container();
        Assert.areEqual(c1, Container.instance);
        var c2 = new Container();
        Assert.areEqual(c2, Container.instance);
    }
    
    @Test
    public function addSystemAddsSystem()
    {
        var container = new Container();
        var expected = new DummySystem();
        container.addSystem(expected);
        Assert.that(container.systems.length, Is.equalTo(1));
        var actual = container.systems[0];
        Assert.areEqual(expected, actual);
    }
    
    @Test
    public function addEntityAddsEntity()
    {
        var container = new Container();
        var expected = new Entity();
        container.addEntity(expected);
        Assert.that(container.entities.length, Is.equalTo(1));
        var actual = container.entities[0];
        Assert.areEqual(expected, actual);
    }
    
    @Test
    public function updateUpdatesAllSystems()
    {
        var container = new Container();
        var s1 = new DummySystem();
        var s2 = new DummySystem();
        container.addSystem(s1);
        container.addSystem(s2);
        
        var expected = 1.0721;
        container.update(0.13);
        container.update(expected);
        Assert.areEqual(expected, s1.lastUpdate);
        Assert.areEqual(expected, s2.lastUpdate);
    }
    
    @Test
    public function entityChangedCallsEntityChangedOnAllSystems()
    {
        var container = new Container();
        var s1 = new DummySystem();
        var s2 = new DummySystem();
        container.addSystem(s1);
        container.addSystem(s2);
        
        var expected = new Entity();
        container.entityChanged(new Entity());
        container.entityChanged(expected);
        Assert.areEqual(expected, s1.whoChanged);
        Assert.areEqual(expected, s2.whoChanged);
    }
}

class DummySystem extends nebula.ecs.system.AbstractSystem
{
    public var lastUpdate(default, null):Float;
    public var whoChanged(default, null):Entity;
    
    public function new()
    {
        super([nebula.ecs.component.AbstractComponent]);
    }
    
    override public function update(elapsed:Float):Void
    {
        this.lastUpdate = elapsed;
    }
    
    override public function entityChanged(e:Entity):Void
    {
        // Causes a serialization infinite loop
        // To get around this, null out the container   
        // If this breaks tests later, maybe I can use
        // a dummy/test entity class with everything but the container.     
        this.whoChanged = e;
        this.whoChanged.container = null;
    }
}
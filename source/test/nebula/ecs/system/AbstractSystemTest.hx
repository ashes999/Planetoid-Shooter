package nebula.ecs.system;

import IntComponent;
import nebula.ecs.component.AbstractComponent;
import nebula.ecs.Entity;
import nebula.ecs.system.AbstractSystem;

using noor.Assert;

// You may find this amusing. It's possible to test base/abstract class code
// in isolation. Then, subclasses only need to test subclassed code! Awesomeness ensues.
@:access(nebula.ecs.system.AbstractSystem)
class AbstractSystemTest
{
    @Test
    public function entityChangedDoesntDoAnythingIfEntityDoesntHaveAllMatchingComponents()
    {
        var system = new IntComponentSystem([IntComponent]);
        var e = new Entity().add(new StringComponent("testing!"));
        system.entityChanged(e);
        Assert.that(system.entities.length, Is.equalTo(0));
    }
    
    @Test
    public function entityChangedTracksNewEntitiesWithAllMatchingComponents()
    {
        var system = new IntComponentSystem([IntComponent]);
        var e = new Entity().add(new StringComponent("testing!")).add(new IntComponent(1));
        system.entityChanged(e);        
        Assert.that(system.entities.length, Is.equalTo(1));
        Assert.areEqual(system.entities[0], e);
    }
    
    @Test
    public function entityChangeRemovesEntitiesThatNoLongerMatchAllComponents()
    {
        var system = new IntComponentSystem([IntComponent]);
        var ic:IntComponent = new IntComponent(1);
        
        var e = new Entity().add(new StringComponent("testing!")).add(ic);
        system.entityChanged(e);        
        Assert.that(system.entities.length, Is.equalTo(1));
        
        e.remove(ic);
        system.entityChanged(e);        
        Assert.that(system.entities.length, Is.equalTo(0));        
    }
}

class IntComponentSystem extends AbstractSystem
{
    public function new(types:Array<Class<AbstractComponent>>)
    {
        super(types);
    }
}
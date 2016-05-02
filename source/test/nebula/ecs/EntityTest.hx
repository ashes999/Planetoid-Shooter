package nebula.ecs;

using massive.munit.Assert;
import nebula.ecs.component.AbstractComponent;
import nebula.ecs.Container;
import nebula.ecs.Entity;

class EntityTest
{
    @Test
    public function constructorSetsContainerToConstainerInstance()
    {
        var c1 = new Container();
        var c2 = new Container();
        var e = new Entity();
        Assert.areEqual(c2, e.container);
    }
    
    @Test
    public function hasReturnsTrueIfComponentExists()
    {
        var e = new Entity().add(new StringComponent("hi"));
        Assert.isTrue(e.has(StringComponent));
        Assert.isFalse(e.has(IntComponent));
    }
    
    @Test
    public function getGetsComponentIfExists()
    {
        var expected = new IntComponent(107);
        var e = new Entity().add(expected);
        Assert.areEqual(expected, e.get(IntComponent));
        Assert.isNull(e.get(StringComponent));
    }
    
    @Test
    public function removeRemovesComponent()
    {
        var s = new StringComponent("named entity");
        var e = new Entity().add(s);
        Assert.areEqual(s, e.get(StringComponent));
        Assert.isTrue(e.has(StringComponent));
        e.remove(s);
        Assert.isNull(e.get(StringComponent));
        Assert.isFalse(e.has(StringComponent));        
    }
}
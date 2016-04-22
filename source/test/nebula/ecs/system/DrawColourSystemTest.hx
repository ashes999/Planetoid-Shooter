package nebula.ecs.system;

import flixel.FlxState;
import IntComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.component.ColourComponent;
import nebula.ecs.Entity;
import nebula.ecs.system.DrawColourSystem;
import StringComponent;

using noor.Assert;

// You may find this amusing. It's possible to test base/abstract class code
// in isolation. Then, subclasses only need to test subclassed code! Awesomeness ensues.
@:access(nebula.ecs.system.DrawColourSystem)
class DrawColourSystemTest
{
    @Test
    public function entitiesNeedAPositionAndColour()
    {
        var system = new DrawColourSystem(new FlxState());
        var e = new Entity().add(new StringComponent("testing!")).add(new IntComponent(1));
        system.entityChanged(e);               
        Assert.that(system.entities.length, Is.equalTo(0));
        
        var e2 = new Entity().add(new PositionComponent(0, 0)).add(new ColourComponent(0, 0, 0, 1, 1));
        system.entityChanged(e2);        
        Assert.that(system.entities.length, Is.equalTo(1));
        Assert.that(system.entities[0], Is.equalTo(e2));
    }
    
    @Test
    public function updateInitializesTheColoursSprite()
    {
        var system = new DrawColourSystem(new FlxState());
        var e = new Entity().add(new PositionComponent(0, 0)).add(new ColourComponent(0, 0, 0, 1, 1));
        system.entityChanged(e);
        Assert.that(e.get(ColourComponent).sprite, Is.equalTo(null));
        system.update(0);
        Assert.isTrue(e.get(ColourComponent).sprite != null);
    }
    
    @Test
    public function updateRemakesTheSpriteIfTheComponentSizeChanges()
    {
        var system = new DrawColourSystem(new FlxState());
        var c = new ColourComponent(0, 0, 0, 32, 32);
        var e = new Entity().add(new PositionComponent(0, 0)).add(c);
        system.entityChanged(e);
        system.update(0);
        
        var s1 = c.sprite;
        Assert.isTrue(s1 != null);
        
        c.width = 64;
        system.update(0);
        var s2 = c.sprite;
        Assert.isTrue(s2 != s1);
        
        c.height = 16;
        system.update(0);
        var s3 = c.sprite;
        Assert.isTrue(s3 != s2);
    }
    
    @Test
    public function updateRemakesTheSpriteIfTheComponentColourChanges()
    {
        var system = new DrawColourSystem(new FlxState());
        var c = new ColourComponent(0, 0, 0, 32, 32);
        var e = new Entity().add(new PositionComponent(0, 0)).add(c);
        system.entityChanged(e);
        system.update(0);
        
        var s1 = c.sprite;
        Assert.isTrue(s1 != null);
        
        c.red = 64;
        system.update(0);
        var s2 = c.sprite;
        Assert.isTrue(s2 != s1);
        
        c.green = 16;
        system.update(0);
        var s3 = c.sprite;
        Assert.isTrue(s3 != s2);
        
        c.blue = 137;
        system.update(0);
        var s4 = c.sprite;
        Assert.isTrue(s4 != s3);
    }
    
    @Test
    public function updateSetsTheSpriteCoordinatesToTheComponentsCoordinates()
    {
        var system = new DrawColourSystem(new FlxState());
        var c = new ColourComponent(0, 0, 0, 32, 32);
        var p = new PositionComponent(17, 29);
        var e = new Entity().add(p).add(c);
        system.entityChanged(e);
        system.update(0);
        
        var sprite = c.sprite;
        Assert.that(sprite.x, Is.equalTo(p.x));
        Assert.that(sprite.y, Is.equalTo(p.y));
        
        // player moves the entity. Does the colour's sprite move?
        p.x = 32;
        p.y = 48;
        
        system.update(0);
        
        Assert.that(sprite.x, Is.equalTo(p.x));
        Assert.that(sprite.y, Is.equalTo(p.y));
    }
    
}
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
        
    }
    
    @Test
    public function updateRemakesTheSpriteIfTheComponentSizeChanges()
    {
        // Test both width and height changes
    }
    
    @Test
    public function updateRemakesTheSpriteIfTheComponentColourChanges()
    {
        // Test red, green, and blue separately
    }
    
    @Test
    public function updateSetsTheSpriteCoordinatesToTheComponentsCoordinates()
    {
        
    }
    
}
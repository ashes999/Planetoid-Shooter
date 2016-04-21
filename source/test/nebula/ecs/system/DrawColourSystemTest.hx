package nebula.ecs.system;

import IntComponent;
import nebula.ecs.component.AbstractComponent;
import nebula.ecs.component.ColourComponent;
import nebula.ecs.Entity;
import nebula.ecs.system.DrawColourSystem;

using noor.Assert;

// You may find this amusing. It's possible to test base/abstract class code
// in isolation. Then, subclasses only need to test subclassed code! Awesomeness ensues.
class DrawColourSystemTest
{
    @Test
    public function entitiesNeedAPositionAndColour()
    {
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
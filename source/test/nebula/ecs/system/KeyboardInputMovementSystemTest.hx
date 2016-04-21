package nebula.ecs.system;

import IntComponent;
import nebula.ecs.component.AbstractComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.Entity;
import nebula.ecs.system.DrawSpriteSystem;

using noor.Assert;

// You may find this amusing. It's possible to test base/abstract class code
// in isolation. Then, subclasses only need to test subclassed code! Awesomeness ensues.
class KeyboardInputMovementSystemTest
{
    @Test
    public function updateMovesPositionIfArrowKeysPressed()
    {
        // up, down, left, right
    }
    
    @Test
    public function updateMovesPositionIfWASDKeysPressed()
    {
        
    }
    
}
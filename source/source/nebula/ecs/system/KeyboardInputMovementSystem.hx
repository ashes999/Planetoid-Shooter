package nebula.ecs.system;

import nebula.ecs.Container;
import nebula.ecs.Entity;
import nebula.ecs.component.AbstractComponent;
import nebula.ecs.component.KeyboardInputComponent;
import nebula.ecs.component.PositionComponent;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

// Looks for KeyboardInputComponents and moves their SpriteComponents to arrow keys or WASD
class KeyboardInputMovementSystem extends AbstractSystem
{
    private var state:FlxState;
    
    public function new(container:Container)
    {
        super(container, [KeyboardInputComponent, PositionComponent]);
    }
        
    override public function update(elapsed:Float):Void
    {
        for (entity in this.entities)
        {
            var component:KeyboardInputComponent = entity.get(KeyboardInputComponent);
            var position:PositionComponent = entity.get(PositionComponent);
                
            var dx:Float = 0;
            var dy:Float = 0;
            var movement:Float = component.moveSpeed * elapsed;
            
            if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A)
            {
                dx = -movement;
            }
            else if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D)
            {
                dx = movement;
            }
                
            if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
            {
                dy = -movement;
            }
            else if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
            {
                dy = movement;
            }
            
            position.x += dx;
            position.y += dy;
        }
    }
}
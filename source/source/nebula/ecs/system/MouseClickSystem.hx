package nebula.ecs.system;

import flixel.FlxG;
import flixel.FlxState;

import nebula.ecs.component.MouseClickComponent;

class MouseClickSystem extends AbstractSystem
{
    
    public function new(state:FlxState)
    {
        super([MouseClickComponent]);
    }
    
    override public function update(elapsed:Float)
    {
        if (flixel.FlxG.mouse.justPressed)
        {

            for (entity in this.entities)
            {
                var mouseClickComponent:MouseClickComponent = entity.get(MouseClickComponent);
                
                for (i in 0 ... mouseClickComponent.callbacks.length)
                {
                    mouseClickComponent.callbacks[i](FlxG.mouse.x, FlxG.mouse.y);
                }
            }
        }
    }
}
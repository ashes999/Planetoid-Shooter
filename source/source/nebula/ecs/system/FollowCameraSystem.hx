package nebula.ecs.system;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;

import nebula.ecs.component.AbstractComponent;
import nebula.ecs.component.CameraComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.Entity;

class FollowCameraSystem extends AbstractSystem
{
    private var state:FlxState;

    public function new(state:FlxState)
    {
        super([CameraComponent,SpriteComponent]);
        this.state = state;
    }
    
    override public function update(elapsed:Float):Void
    {
        if(this.entities.length > 1)
        {
            throw "Camera can't follow more than one entity";
        }
        else if(this.entities.length == 1)
        {   
            var sprite:SpriteComponent = this.entities[0].get(SpriteComponent);

            if (FlxG.camera.target != sprite.sprite)
            {   
                FlxG.camera.follow(sprite.sprite);
            }
        }
        else if (FlxG.camera.target != null)
        {
            FlxG.camera.follow(null);
        }
    }
}
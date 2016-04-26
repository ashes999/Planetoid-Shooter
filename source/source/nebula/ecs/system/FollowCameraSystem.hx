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
        super([SpriteComponent,CameraComponent]);
        this.state = state;
    }
    
    override public function update(elapsed:Float):Void
    {
        for (entity in this.entities)
        {
            var sprite:SpriteComponent = entity.get(SpriteComponent);
            //if this is the latest entity with this camera component & the camera is not following it
            //this is subject to change depending on discussion 
            if (entity == entities[entities.length-1] && flixel.FlxG.camera.target != sprite.sprite)
            {   
                flixel.FlxG.camera.follow(sprite.sprite);
            }
        }
    }
}
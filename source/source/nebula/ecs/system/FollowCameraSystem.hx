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
        var sprite:SpriteComponent = this.entities[0].get(SpriteComponent);

        if (flixel.FlxG.camera.target != sprite.sprite)
        {   
            flixel.FlxG.camera.follow(sprite.sprite);
        }
    }
    override public function entityChanged(entity:Entity):Void
    {
        if(this.entities.length > 0 && entity != this.entities[0])
            throw "Camera can't follow more than one entity";

        super.entityChanged(entity);
    }
}
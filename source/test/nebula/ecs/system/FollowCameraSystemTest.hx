package nebula.ecs.system;

import flixel.FlxState;
import flixel.FlxG;
import IntComponent;
import StringComponent;
using massive.munit.Assert;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.component.CameraComponent;
import nebula.ecs.Entity;
import nebula.ecs.system.FollowCameraSystem;


@:access(nebula.ecs.system.FollowCameraSystem)
class FollowCameraSystemTest
{
    @Test
    public function entitiesNeedASpriteAndCamera()
    {
        var system = new FollowCameraSystem(new FlxState());
        
        var entity:Entity = new Entity().add(new StringComponent("testing!")).add(new IntComponent(1));
        system.entityChanged(entity);
        Assert.areEqual(0, system.entities.length);
        
        system = new FollowCameraSystem(new FlxState());
        entity = new Entity().add(new SpriteComponent("fakeImage"));
        system.entityChanged(entity);
        Assert.areEqual(0, system.entities.length);


        entity = new Entity().add(new PositionComponent(0,0)).add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
        system.entityChanged(entity);

        Assert.areEqual(1, system.entities.length);
        Assert.areEqual(entity, system.entities[0]);
    }
    
    @Test
    public function updateInitializesCameraFollow()
    {
        var system = new FollowCameraSystem(new FlxState());

        var entity:Entity = new Entity().add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
        system.entityChanged(entity);
        
        Assert.isNull(FlxG.camera.target);
        system.update(0);
        Assert.areEqual(entity.get(SpriteComponent).sprite, FlxG.camera.target);
    }

    @Test
    public function addingMoreThanOneEntityThrowsException()
    {
        var system = new FollowCameraSystem(new FlxState());

        var entity = new Entity().add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
        system.entityChanged(entity);
        
        entity = new Entity().add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());

        var message:String = Assert2.throws(String, function()
        {
            system.entityChanged(entity);
            system.update(0);
        });

        Assert.areEqual("Camera can't follow more than one entity", message);
    }

    @Test
    public function removingCameraComponentResetCameraTarget()
    {
        var system = new FollowCameraSystem(new FlxState());

        var entity:Entity = new Entity().add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
        system.entityChanged(entity);
        
        Assert.isNull(FlxG.camera.target);

        system.update(0);
        Assert.areEqual(entity.get(SpriteComponent).sprite, FlxG.camera.target);

        entity.remove(CameraComponent);
        system.update(0);
        Assert.isNull(FlxG.camera.target);
    }
}
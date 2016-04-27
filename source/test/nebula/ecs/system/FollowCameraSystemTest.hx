package nebula.ecs.system;

import flixel.FlxState;
import flixel.FlxG;

import nebula.ecs.component.PositionComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.component.CameraComponent;

import nebula.ecs.system.FollowCameraSystem;

import IntComponent;
import StringComponent;

import nebula.ecs.Entity;

import noor.AssertionException;

using noor.Assert;

@:access(nebula.ecs.system.FollowCameraSystem)
class FollowCameraSystemTest
{
    @Test
    public function entitiesNeedASpriteAndCamera()
    {
        var system = new FollowCameraSystem(new FlxState());
        
        var entity:Entity = new Entity().add(new StringComponent("testing!")).add(new IntComponent(1));
        system.entityChanged(entity);
        Assert.that(system.entities.length, Is.equalTo(0));
        
        system = new FollowCameraSystem(new FlxState());
        entity = new Entity().add(new SpriteComponent("fakeImage"));
        system.entityChanged(entity);
        Assert.that(system.entities.length, Is.equalTo(0));


        entity = new Entity().add(new PositionComponent(0,0)).add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
        system.entityChanged(entity);

        Assert.that(system.entities.length, Is.equalTo(1));
        Assert.that(system.entities[0], Is.equalTo(entity));
    }
    
    @Test
    public function updateInitializesCameraFollow()
    {
        var system = new FollowCameraSystem(new FlxState());

        var entity:Entity = new Entity().add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
        system.entityChanged(entity);
        
        Assert.that(FlxG.camera.target, Is.equalTo(null));
        system.update(0);
        Assert.that(FlxG.camera.target, Is.equalTo(entity.get(SpriteComponent).sprite));
    }

    @Test
    public function addingMoreThanOneEntityThrowsException()
    {
        var system = new FollowCameraSystem(new FlxState());

        var entity = new Entity().add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
        system.entityChanged(entity);


        Assert.throws(String, function()
        {
            entity = new Entity().add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
            system.entityChanged(entity);
        });

    }

    @Test
    public function removingCameraComponentResetCameraTarget()
    {
        var system = new FollowCameraSystem(new FlxState());

        var entity:Entity = new Entity().add(new SpriteComponent("assets/apple.png")).add(new CameraComponent());
        system.entityChanged(entity);
        
        Assert.that(FlxG.camera.target, Is.equalTo(null));

        system.update(0);
        Assert.that(FlxG.camera.target, Is.equalTo(entity.get(SpriteComponent).sprite));

        entity.remove(new CameraComponent());
        system.update(0);
        Assert.that(FlxG.camera.target, Is.equalTo(null));
    }
}
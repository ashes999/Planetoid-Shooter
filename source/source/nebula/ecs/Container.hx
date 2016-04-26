package nebula.ecs;

import flixel.FlxState;

import nebula.ecs.component.AbstractComponent;
import nebula.ecs.system.AbstractSystem;
import nebula.ecs.system.DrawSpriteSystem;
import nebula.ecs.system.DrawColourSystem;
import nebula.ecs.system.KeyboardInputMovementSystem;
import nebula.ecs.system.FollowCameraSystem;

// The main class that glues everything together. In Ash, this is called "engine."
// A collection of components and systems. Use this per screen or whatever.
class Container
{
    public static var instance(default, null):Container;
    public var entities:Array<Entity>;
    public var systems:Array<AbstractSystem>;
    
    public function new()
    {
        instance = this;
        this.entities = new Array<Entity>();
        this.systems = new Array<AbstractSystem>();
    }
    
    public function update(elapsed:Float):Void
    {
        for (system in systems)
        {
            system.update(elapsed);
        }
    }
    
    public function addSystem(system:AbstractSystem):Container
    {
        this.systems.push(system);
        system.create();
        return this;
    }
    
    public function addEntity(entity:Entity):Void
    {
        entity.container = this;
        this.entities.push(entity);
        for (system in systems)
        {
            this.entityChanged(entity);
        }
    }
    
    public function entityChanged(entity:Entity):Void
    {
        for (system in this.systems)
        {
            system.entityChanged(entity);
        }
    }
    
    public function addDefaultSystems(state:FlxState):Void
    {
        this.addSystem(new DrawSpriteSystem(state))
            .addSystem(new DrawColourSystem(state))
            .addSystem(new KeyboardInputMovementSystem())
            .addSystem(new FollowCameraSystem(state));
    }
}
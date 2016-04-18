package nebula.ecs;

import flixel.FlxState;

import nebula.ecs.component.AbstractComponent;
import nebula.ecs.system.AbstractSystem;
import nebula.ecs.system.DrawSpriteSystem;
import nebula.ecs.system.DrawColourSystem;
import nebula.ecs.system.KeyboardInputMovementSystem;

// The main class that glues everything together. In Ash, this is called "engine."
// A collection of components and systems. Use this per screen or whatever.
class Container
{
    public var entities:Array<Entity>;
    public var systems:Array<AbstractSystem>;
    
    public function new()
    {
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
    
    // Get all entities with a component
    public function get(componentClass:Class<AbstractComponent>):Array<Entity>
    {
        var toReturn:Array<Entity> = [];
        for (e in this.entities)
        {
            if (e.has(componentClass))
            {
                toReturn.push(e);
            }
        }
        return toReturn;
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
            .addSystem(new KeyboardInputMovementSystem());
    }
}
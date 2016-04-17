package pulsar.ecs;

import pulsar.ecs.component.AbstractComponent;
import pulsar.ecs.system.AbstractSystem;

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
    
    public function addSystem(s:AbstractSystem):Container
    {
        this.systems.push(s);
        s.create();
        return this;
    }
    
    public function update(elapsed:Float):Void
    {
        for (system in systems)
        {
            system.update(elapsed);
        }
    }
    
    public function add(entity:Entity):Void
    {
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
}
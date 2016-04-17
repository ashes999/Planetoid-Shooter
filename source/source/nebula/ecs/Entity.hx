package nebula.ecs;

import nebula.ecs.component.AbstractComponent;
import nebula.ecs.Container;


// DO NOT USE THIS CLASS. It's just a convenient way to get groups of related
// components together for systems to act on. Srsly.
class Entity
{
    private var container:Container;
    private var components:Map<String, AbstractComponent>;
    private var tags(default, null):Array<String>;
    
    public function new(container:Container)
    {
        this.container = container;
        this.components = new Map<String, AbstractComponent>();
        this.tags = [];
    }
    
    // You can only have one of each component by type
    public function add(component:AbstractComponent):Entity
    {
        var name = Type.getClassName(Type.getClass(component));
        this.components.set(name, component);
        this.container.entityChanged(this);
        return this;
    }
    
    public function remove(component:AbstractComponent):Entity
    {
        var name = Type.getClassName(Type.getClass(component));
        this.components.remove(name);
        this.container.entityChanged(this);
        return this;
    }
    
    // c is a Class<AbstractComponent> eg. SpriteComponent
    public function get<T>(c:Class<T>):T
    {
        var name:String = Type.getClassName(c);
        return cast(this.components.get(name));
    }
    
    public function has(c:Class<AbstractComponent>):Bool
    {
        return this.get(c) != null;
    }
}
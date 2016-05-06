package nebula.ecs;

import nebula.ecs.component.AbstractComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.Container;

class Entity
{
    public var container(default, default):Container;
    private var components:Map<String, AbstractComponent>;
    private var tags(default, null):Array<String>;
    
    public function new()
    {
        this.container = Container.instance;
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
    
    /**
    Remove a component from this entity. (eg. e.remove(SpriteComponent))
    Does nothing if the component doesn't have that entity.
    */
    public function remove(clazz:Class<AbstractComponent>):Entity
    {
        var name = Type.getClassName(clazz);
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
        
    ////////////////////// Start fluent API //////////////////////
    
    public function move(x:Int, y:Int):Entity
    {
        this.add(new PositionComponent(x, y));
        return this;
    } 
    
    public function sprite(image:String, repeat:Bool = false):Entity
    {
        this.add(new SpriteComponent(image, repeat));
        return this;
    }    
    
    /////////////////////// End fluent API ///////////////////////
}
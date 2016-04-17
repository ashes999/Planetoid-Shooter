package pulsar.ecs.system;

import pulsar.ecs.Container;
import pulsar.ecs.component.AbstractComponent;
import pulsar.ecs.component.SpriteComponent;
import pulsar.ecs.Entity;

import flixel.FlxSprite;
import flixel.FlxState;

// Looks for and initializes SpriteComponent instances
class DrawSpriteSystem extends AbstractSystem
{
    private var state:FlxState;
    
    public function new(container:Container, state:FlxState)
    {
        super(container, [SpriteComponent]);
        this.state = state;
    }
    
    override public function update(elapsed:Float):Void
    {
        for (entity in this.entities)
        {
            var component:SpriteComponent = entity.get(SpriteComponent);            
            if (component.sprite == null)
            {
                var s:FlxSprite = new FlxSprite();
                s.loadGraphic(component.image);
                trace('loaded ${component.image}');
                component.sprite =  s;
                this.state.add(s);
            }
            
            component.sprite.x = component.x;
            component.sprite.y = component.y;
        }
    }
}
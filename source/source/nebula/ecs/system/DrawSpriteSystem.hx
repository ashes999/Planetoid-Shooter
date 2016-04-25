package nebula.ecs.system;

import nebula.ecs.component.AbstractComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.Entity;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
// Looks for and initializes SpriteComponent instances
class DrawSpriteSystem extends AbstractSystem
{
    private var state:FlxState;
    
    public function new(state:FlxState)
    {
        super([SpriteComponent, PositionComponent]);
        this.state = state;
    }
    
    override public function update(elapsed:Float):Void
    {
        for (entity in this.entities)
        {
            var sprite:SpriteComponent = entity.get(SpriteComponent);            
            if (sprite.sprite == null)
            {
                if(sprite.isRepeating)
                {
                    var s:FlxBackdrop = new FlxBackdrop(sprite.image);
                    sprite.sprite =  s;
                    this.state.add(s);
                }
                else
                {
                    var s:FlxSprite = new FlxSprite();
                    s.loadGraphic(sprite.image);
                    sprite.sprite =  s;
                    this.state.add(s);
                }
            }
            
            var position:PositionComponent = entity.get(PositionComponent);
            sprite.sprite.x = position.x;
            sprite.sprite.y = position.y;
        }
    }
}
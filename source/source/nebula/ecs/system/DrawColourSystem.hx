package nebula.ecs.system;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;

import nebula.ecs.component.AbstractComponent;
import nebula.ecs.component.ColourComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.Entity;

class DrawColourSystem extends AbstractSystem
{
    private var state:FlxState;
    
    public function new(state:FlxState)
    {
        super([ColourComponent, PositionComponent]);
        this.state = state;
    }
    
    override public function update(elapsed:Float):Void
    {
        for (entity in this.entities)
        {
            var colour:ColourComponent = entity.get(ColourComponent);            
            if (colour.sprite == null)
            {
                var s:FlxSprite = this.makeSprite(colour);
                this.state.add(s);
            }
            else
            {
                // Sprite height doesn't match component height
                if (colour.sprite.width != colour.width || colour.sprite.height != colour.height
                // Sprite colour doesn't match component colour
                    || colour.sprite.color.red != colour.red || colour.sprite.color.green != colour.green || colour.sprite.color.blue != colour.blue )
                {
                    this.state.remove(colour.sprite);
                    this.makeSprite(colour);
                    this.state.add(colour.sprite);
                }
            }
            
            var position:PositionComponent = entity.get(PositionComponent);
            colour.sprite.x = position.x;
            colour.sprite.y = position.y;
        }
    }
    
    private function makeSprite(colour:ColourComponent):FlxSprite
    {
        var flxColor:FlxColor = FlxColor.fromRGB(colour.red, colour.green, colour.blue);
        var toReturn:FlxSprite = new FlxSprite();
        toReturn.makeGraphic(colour.width, colour.height, flxColor);      
        // Not required (tints), but stores the colour so we can read it later
        toReturn.color = flxColor;
        colour.sprite =  toReturn;
        return toReturn;
    }
}
package nebula.ecs.component;

import flixel.FlxSprite;

class SpriteComponent extends AbstractComponent
{
    public var image:String = "";
    
    // internal
    public var sprite:FlxSprite;
    public var isRepeating:Bool;

    public function new(fileName:String,isRepeating:Bool = false)
    {
        super();
        this.image = fileName;
        this.isRepeating = isRepeating;
    }
}
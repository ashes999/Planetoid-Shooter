package nebula.ecs.component;

import flixel.FlxSprite;

class SpriteComponent extends AbstractComponent
{
    public var image:String = "";
    
    // internal
    public var sprite:FlxSprite;

    public function new(fileName:String)
    {
        super();
        this.image = fileName;
    }
}
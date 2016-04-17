package nebula.ecs.component;

import flixel.FlxSprite;

class SpriteComponent extends AbstractComponent
{
    public var image:String = "";
    public var x:Float = 0;
    public var y:Float = 0;
    
    // internal
    public var sprite:FlxSprite;

    public function new(fileName:String)
    {
        super();
        this.image = fileName;
    }
}
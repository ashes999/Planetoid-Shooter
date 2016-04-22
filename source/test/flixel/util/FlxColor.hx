package flixel.util;

class FlxColor
{
    public var red:Int = 0;
    public var green:Int = 0;
    public var blue:Int = 0;
    
    public function new() { }
    
    public static function fromRGB(red:Int, green:Int, blue:Int):FlxColor
    {
        return new FlxColor();
    }
}
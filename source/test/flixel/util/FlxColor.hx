package flixel.util;

class FlxColor
{
    public var red:Int;
    public var green:Int;
    public var blue:Int;
    
    public function new() { }
    
    public static function fromRGB(red:Int, green:Int, blue:Int):FlxColor
    {
        return new FlxColor();
    }
}
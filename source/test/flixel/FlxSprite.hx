package flixel;

import flixel.util.FlxColor;

class FlxSprite {
    public var x:Float;
    public var y:Float;
    public var width:Int;
    public var height:Int;
    public var color:FlxColor;
    public function new() { }
    public function loadGraphic(asset:String) { } 
    public function makeGraphic(width:Int, height:Int, color:FlxColor) {
        this.width = width;
        this.height = height;
    }   
}
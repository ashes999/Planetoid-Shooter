package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
    public static var instance(default, null):Main;
    
	public function new()
	{
        instance = this;
        
		super();
		addChild(new FlxGame(800, 600, PlayState, 1, 60, 60, true));
	}
}
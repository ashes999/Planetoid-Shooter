package;

import flixel.FlxGame;
import openfl.display.Sprite;
import noor.web.Request;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(800, 600, PlayState, 1, 60, 60, true));
        trace('URL parameters: ${noor.web.Request.getUrlParameters()}');
	}
}
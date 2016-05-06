package;

import flixel.FlxGame;
import openfl.display.Sprite;
import noor.io.ConfigReader;
import noor.web.Request;

class Main extends Sprite
{
	public function new()
	{
		super();
                
        var json = "{}"; // todo: read from external.json
        var urlParameters = noor.web.Request.getUrlParameters();
        ConfigReader.load(json, urlParameters);

		addChild(new FlxGame(800, 600, PlayState, 1, 60, 60, true));
	}
}
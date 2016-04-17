package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import deengames.planetoid.state.PlanetoidState;

class PlayState extends PlanetoidState
{
	override public function create():Void
	{
		super.create();
        this.entityFactory.createPlayer();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}

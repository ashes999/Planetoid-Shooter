package;

import deengames.planetoid.entity.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import nebula.ecs.Container;

class PlayState extends FlxState
{
	private var container:Container = new Container();
    
	override public function create():Void
	{
		super.create();
        container.addDefaultSystems(this);
        container.add(Player.create(container));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        this.container.update(elapsed);
	}
}

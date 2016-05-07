package;

import deengames.planetoid.entity.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import nebula.ecs.Container;
import nebula.ecs.Entity;

class PlayState extends FlxState
{
	private var container:Container = new Container();
    
	override public function create():Void
	{
		super.create();
        container.addDefaultSystems(this);

        var background:Entity = new Entity()
            .move(0, 0)
            .image('assets/images/background.jpg',true);
        
        Player.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        container.update(elapsed);
	}
}

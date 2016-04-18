package;

import deengames.planetoid.entity.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import nebula.ecs.Container;
import nebula.ecs.system.DrawSpriteSystem;
import nebula.ecs.system.DrawColourSystem;
import nebula.ecs.system.KeyboardInputMovementSystem;

class PlayState extends FlxState
{
	private var container:Container = new Container();
    
	override public function create():Void
	{
		super.create();
        container.addSystem(new DrawSpriteSystem(container, this))
            .addSystem(new DrawColourSystem(container, this))
            .addSystem(new KeyboardInputMovementSystem(container));
        
        container.add(Player.create(container));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        this.container.update(elapsed);
	}
}

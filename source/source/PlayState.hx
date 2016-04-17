package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import pulsar.ecs.Container;
import pulsar.ecs.Entity;
import pulsar.ecs.component.KeyboardInputComponent;
import pulsar.ecs.component.SpriteComponent;
import pulsar.ecs.system.DrawSpriteSystem;
import pulsar.ecs.system.KeyboardInputMovementSystem;

class PlayState extends FlxState
{
	private var container:Container = new Container();
    
	override public function create():Void
	{
		super.create();
        container.addSystem(new DrawSpriteSystem(container, this))
            .addSystem(new KeyboardInputMovementSystem(container));
        
        container.add(new Entity(container)
            .add(new SpriteComponent("assets/images/butterfly.png"))
            .add(new KeyboardInputComponent(100)));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        this.container.update(elapsed);
	}
}

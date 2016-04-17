package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import nebula.ecs.Container;
import nebula.ecs.Entity;
import nebula.ecs.component.KeyboardInputComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.system.DrawSpriteSystem;
import nebula.ecs.system.KeyboardInputMovementSystem;

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

# [Planetoid Shooter](http://deengames-prototypes.github.io/planetoid-shooter)

A 2D, top-down sci-fi shooter with a multiple gameplay modes. Survive on a small planetoid as meteors full of aliens land. Defeat and master each different and challenging enemy with an array of different weapons.

## Nebula
Nebula is a batteries-included extension for HaxeFlixel. It includes an entity-component framework/system, and others.

Small example of a sprite that responds to keyboard movement:
```
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
```

Example of a system that initializes and draws sprites:

```
class DrawSpriteSystem extends AbstractSystem
{
    private var state:FlxState;
    
    public function new(container:Container, state:FlxState)
    {
        super(container, [SpriteComponent]);
        this.state = state;
    }
    
    override public function update(elapsed:Float):Void
    {
        for (entity in this.entities)
        {
            var component:SpriteComponent = entity.get(SpriteComponent);            
            if (component.sprite == null)
            {
                var s:FlxSprite = new FlxSprite();
                s.loadGraphic(component.image);
                component.sprite =  s;
                this.state.add(s);
            }
            
            component.sprite.x = component.x;
            component.sprite.y = component.y;
        }
    }
}
```
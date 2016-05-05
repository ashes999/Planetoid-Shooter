# Nebula
Nebula is a batteries-included extension for HaxeFlixel. It includes an entity-component framework (and pre-built system), and others.

The entity-component system is inspired by the [Ash framework](http://ashframework.org/)'s design philosophy:
- Components are pure data (no code)
- Entities are just bags of components
- Systems are thin and operate on just what they need

Unlike Ash, Nebula doesn't use nodes (which seem like boilerplate code), with the trade-off that systems operate directly on entities.

Ash is also a framework; Nebula includes a set of systems for writing HaxeFlixel games. See the [list of systems](tree/gh-pages/source/source/nebula/ecs/system) in code.
  
Small example of a state with a orange square that responds to keyboard movement:

```
class PlayState extends FlxState
{
	private var container:Container = new Container();
    
	override public function create():Void
	{
		super.create();
        container.addDefaultSystems(this);
        
        container.add(new Entity(container)
            .add(new ColourComponent(255, 128, 0, 48, 48))
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
        // Get all entities that have both a sprite and a position
        super(container, [SpriteComponent, PositionComponent]);
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
            
            var pos:PositionComponent = entity.get(PositionComponent);
            component.sprite.x = pos.x;
            component.sprite.y = pos.y;
        }
    }
}
```
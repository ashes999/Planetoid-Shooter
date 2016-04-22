package nebula.ecs.system;

import flixel.FlxState;
import IntComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.Entity;
import nebula.ecs.system.DrawSpriteSystem;

using noor.Assert;

@:access(nebula.ecs.system.DrawSpriteSystem)
class DrawSpriteSystemTest
{
    @Test
    public function entitiesNeedAPositionAndSprite()
    {
        var system = new DrawSpriteSystem(new FlxState());
        var e = new Entity().add(new StringComponent("testing!")).add(new IntComponent(1));
        system.entityChanged(e);               
        Assert.that(system.entities.length, Is.equalTo(0));
        
        var e2 = new Entity().add(new PositionComponent(0, 0)).add(new SpriteComponent("not used.png"));
        system.entityChanged(e2);        
        Assert.that(system.entities.length, Is.equalTo(1));
        Assert.that(system.entities[0], Is.equalTo(e2));
    }
    
    @Test
    public function updateInitializesTheSpritesSprite()
    {
        var system = new DrawSpriteSystem(new FlxState());
        var e = new Entity()
            .add(new PositionComponent(0, 0))
            .add(new SpriteComponent("assets/apple.png"));
        system.entityChanged(e);
        Assert.that(e.get(SpriteComponent).sprite, Is.equalTo(null));
        system.update(0);
        Assert.isTrue(e.get(SpriteComponent).sprite != null);
    }
    
    @Test
    public function updateSetsTheSpriteCoordinatesToTheComponentsCoordinates()
    {
        var system = new DrawSpriteSystem(new FlxState());
        var s = new SpriteComponent("assets/ball.png");
        var p = new PositionComponent(135, 208);
        var e = new Entity().add(p).add(s);
        system.entityChanged(e);
        system.update(0);
        
        var sprite = s.sprite;
        Assert.that(sprite.x, Is.equalTo(p.x));
        Assert.that(sprite.y, Is.equalTo(p.y));
        
        // player moves the entity. Does the sprite's sprite move?
        p.x = 32;
        p.y = 65;
        
        system.update(0);
        
        Assert.that(sprite.x, Is.equalTo(p.x));
        Assert.that(sprite.y, Is.equalTo(p.y));
    }
    
}
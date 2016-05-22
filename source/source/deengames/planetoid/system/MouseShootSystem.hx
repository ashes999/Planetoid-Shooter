package deengames.planetoid.system;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;

import flixel.addons.weapon.FlxWeapon;
import flixel.addons.weapon.FlxBullet;
import flixel.util.helpers.FlxBounds;
import flixel.math.FlxPoint;

import deengames.planetoid.component.MouseShootComponent;

import nebula.ecs.component.MouseClickComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.system.AbstractSystem;
import nebula.ecs.Entity;

class MouseShootSystem extends AbstractSystem
{
    private var state:FlxState;
    
    public function new(state:FlxState)
    {
        super([MouseShootComponent, MouseClickComponent, SpriteComponent]);
        this.state = state;
    }
    
    
    override public function entityChanged(entity:Entity):Void
    {
        super.entityChanged(entity);

        for (entity in this.entities)
        {
            var mouseShootComponent:MouseShootComponent = this.entities[0].get(MouseShootComponent);
            var spriteComponent:SpriteComponent = this.entities[0].get(SpriteComponent);
            var sprite = spriteComponent.sprite;
            if (mouseShootComponent.gun == null)
            {
                mouseShootComponent.gun = new FlxWeapon("gun",createNormalGunBullet,
                                FlxWeaponFireFrom.PARENT(spriteComponent.sprite, new FlxBounds(new FlxPoint(sprite.width / 2, sprite.height / 2),
                                                                                                 new FlxPoint(sprite.width / 2, sprite.height / 2))),
                                FlxWeaponSpeedMode.SPEED(new FlxBounds(150.0, 200)));
                mouseShootComponent.gun.fireRate = mouseShootComponent.fireRate;
                mouseShootComponent.gun.bulletLifeSpan = mouseShootComponent.bulletLifeSpan;
                mouseShootComponent.gun.rotateBulletTowardsTarget = true;
                
                //TODO : find a way to set map bounds
                //mouseShootComponent.gun.bounds = mouseShootComponent.bounds;
            }
        }
    }
    public function createNormalGunBullet(weapon:FlxTypedWeapon<FlxBullet>):FlxBullet
    {
        var bullet = new FlxBullet();
        bullet.makeGraphic(8,4);
        state.add(bullet);
        return bullet;
    }
}
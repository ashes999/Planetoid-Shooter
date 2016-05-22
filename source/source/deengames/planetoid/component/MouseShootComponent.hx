package deengames.planetoid.component;

import flixel.FlxSprite;
import flixel.FlxG;

import nebula.ecs.component.AbstractComponent;
import flixel.addons.weapon.FlxWeapon;
import flixel.addons.weapon.FlxBullet;
import flixel.util.helpers.FlxBounds;

import flixel.math.FlxPoint;

class MouseShootComponent extends AbstractComponent
{
    private var speed:Int=5;
    public var gun:FlxWeapon;
    public var fireRate:Int;
    public var bulletLifeSpan = new FlxBounds(1.4, 1.8);
    
    public function new()
    {
        super();
        this.fireRate = 200;
        this.bulletLifeSpan = new FlxBounds(1.4, 1.8);
    }
}
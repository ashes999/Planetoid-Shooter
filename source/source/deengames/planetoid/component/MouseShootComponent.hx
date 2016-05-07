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
    public function new()
    {
        super();
        gun = new FlxWeapon("gun",shrug,FlxWeaponFireFrom.POSITION(new FlxBounds(new FlxPoint(0,0), new FlxPoint(0,0))),FlxWeaponSpeedMode.SPEED(new FlxBounds(0.0,10)));
        //FlxWeaponFireMode.FIRE_AT_MOUSE,
        trace(gun.fireAtMouse());
    }
    public function shrug(weapon:FlxTypedWeapon<FlxBullet>):FlxBullet
    {
    	var bullet = new FlxBullet();
    	bullet.makeGraphic(120,50);
    	FlxG.state.add(bullet);
    	FlxG.watch.add(bullet,"x");
    	return bullet;

    }
}
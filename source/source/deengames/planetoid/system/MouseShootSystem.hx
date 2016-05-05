package deengames.planetoid.system;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;

import flixel.addons.weapon.FlxWeapon;

import deengames.planetoid.component.MouseShootComponent;

import nebula.ecs.component.MouseClickComponent;
import nebula.ecs.system.AbstractSystem;
import nebula.ecs.Entity;

class MouseShootSystem extends AbstractSystem
{
    private var state:FlxState;
    
    public function new(state:FlxState)
    {
        super([MouseShootComponent, MouseClickComponent]);
        this.state = state;
    }
    
    
    override public function entityChanged(entity:Entity):Void
    {
        super.entityChanged(entity);
    }
}
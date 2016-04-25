package deengames.planetoid.entity;

import nebula.ecs.Container;
import nebula.ecs.component.KeyboardInputComponent;
import nebula.ecs.component.ColourComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.Entity;


class Player
{
    // TODO: replace with a fluent interface
    // eg. new Entity().color(255, 0, 0).size(32, 32).move(0, 0).moveToKeyboard(100);
    public static function create():Entity
    {
        return new Entity()
            .add(new ColourComponent(255, 0, 0, 32, 32))
            .add(new SpriteComponent('assets/images/butterfly.png',true))
            .add(new PositionComponent(0, 0))
            .add(new KeyboardInputComponent(100));
    }
}
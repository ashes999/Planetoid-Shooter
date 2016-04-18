package deengames.planetoid.entity;

import nebula.ecs.Container;
import nebula.ecs.component.KeyboardInputComponent;
import nebula.ecs.component.ColourComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.Entity;


class Player
{
    public static function create():Entity
    {
        return new Entity()
            .add(new ColourComponent(255, 0, 0, 32, 32))
            //.add(new SpriteComponent('assets/images/butterfly.png'))
            .add(new PositionComponent(0, 0))
            .add(new KeyboardInputComponent(100));
    }
}
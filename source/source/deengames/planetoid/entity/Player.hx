package deengames.planetoid.entity;

import nebula.ecs.Container;
import nebula.ecs.component.KeyboardInputComponent;
import nebula.ecs.component.ColourComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.component.CameraComponent;
import nebula.ecs.component.MouseClickComponent;
import nebula.ecs.Entity;


class Player
{
    // TODO: replace with a fluent interface
    // eg. new Entity().color(255, 0, 0).size(32, 32).move(0, 0).moveToKeyboard(100);
    public static function create():Entity
    {
        var entity:Entity =  new Entity()
                            .sprite('assets/images/butterfly.png')
                            .move(0, 0)
                            .add(new KeyboardInputComponent(100))
                            .add(new CameraComponent())
                            .add(new MouseClickComponent());
        var mouseClickComponent:MouseClickComponent = entity.get(MouseClickComponent);
        mouseClickComponent.registerCallBack(function(x:Float,y:Float){trace(x,y);});
        return entity;
    }
}
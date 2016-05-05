package deengames.planetoid.entity;

import nebula.ecs.Container;
import nebula.ecs.component.KeyboardInputComponent;
import nebula.ecs.component.ColourComponent;
import nebula.ecs.component.SpriteComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.component.CameraComponent;
import nebula.ecs.component.MouseClickComponent;
import nebula.ecs.Entity;

import deengames.planetoid.component.MouseShootComponent;
 

class Player
{
    // TODO: replace with a fluent interface
    // eg. new Entity().color(255, 0, 0).size(32, 32).move(0, 0).moveToKeyboard(100);
    public static function create():Entity
    {
        var entity:Entity =  new Entity()
                            .add(new ColourComponent(255, 0, 0, 32, 32))
                            .add(new SpriteComponent('assets/images/butterfly.png'))
                            .add(new PositionComponent(0, 0))
                            .add(new KeyboardInputComponent(100))
                            .add(new CameraComponent());

        var mouseClickComponent:MouseClickComponent = new MouseClickComponent();
        mouseClickComponent.registerCallBack(function(x:Int,y:Int){trace("1",x,y);});
        mouseClickComponent.registerCallBack(function(x:Int,y:Int){trace("2",x,y);});
        var func = function(x:Int,y:Int){trace("3",x,y);};  
        mouseClickComponent.registerCallBack(func);
        mouseClickComponent.removeCallBack(func);
        entity.add(mouseClickComponent);

        var mouseShootComponent:MouseShootComponent = new MouseShootComponent();
        entity.add(mouseShootComponent);
        

        return entity;
    }
}
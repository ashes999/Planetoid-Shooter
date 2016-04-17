package deengames.planetoid.factory;

import ash.core.Engine;
import ash.core.Entity;

import nebula.ecs.component.ColourComponent;

// TODO: break this class up if it gets too fancy-pants
class EntityFactory
{
    
    private var engine:Engine;
    
    public function new(engine:Engine)
    {
        this.engine = engine;
    }
    
    public function createPlayer():Entity
    {
        var player:Entity = new Entity()
            .add(new ColourComponent(255, 0, 0, 64, 64));
            
        engine.addEntity(player);
        return player;    
    }
}
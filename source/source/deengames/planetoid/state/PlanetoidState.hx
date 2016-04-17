package deengames.planetoid.state;

import deengames.planetoid.factory.EntityFactory;

import nebula.NebulaState;

class PlanetoidState extends NebulaState
{
    private var entityFactory:EntityFactory;
    
    override public function create():Void
    {
        super.create();
        this.entityFactory = new EntityFactory(this.engine);
    }
}
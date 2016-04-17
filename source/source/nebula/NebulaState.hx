package nebula;

import ash.tick.ITickProvider;
import ash.tick.FrameTickProvider;
import ash.core.Engine;

import deengames.planetoid.factory.EntityFactory;

import flixel.FlxState;

import nebula.ecs.system.RenderSystem;

class NebulaState extends FlxState
{
    private var engine:Engine;
    private var tickProvider:ITickProvider;
    
    override public function create():Void
    {
        super.create();
        this.engine = new Engine();
        this.tickProvider = new FrameTickProvider(Main.instance);
        this.tickProvider.add(engine.update);
        this.tickProvider.start();
        engine.addSystem(new RenderSystem(this), 0);
    }
    
    override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
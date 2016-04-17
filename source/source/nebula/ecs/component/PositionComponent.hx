package nebula.ecs.component;

class PositionComponent
{
    public var x:Int = 0;
    public var y:Int = 0;
    
    public function new(x:Int, y:Int)
    {
        this.x = x;
        this.y = y;
    }
}
package nebula.ecs.component;

// 2D rectangle of a specified colour
class ColourComponent
{
    public var red:Int = 0;
    public var green:Int = 0;
    public var blue:Int = 0;
    public var width:Int = 0;
    public var height:Int = 0;
    
    public function new(red:Int, green:Int, blue:Int, width:Int, height:Int)
    {
        this.red = red;
        this.green = green;
        this.blue = blue;
        this.width = width;
        this.height = height;
    }
}

package nebula.ecs.component;

import flixel.FlxSprite;

class MouseClickComponent extends AbstractComponent
{
    public var callbacks:Array<Int->Int->Void>;
    
    // internal
    public var sprite:FlxSprite;

    public function new()
    {
        super();
        callbacks = new Array<Int->Int->Void>();
    }

    public function registerCallBack(callback:Int->Int->Void)
    {
    	callbacks.push(callback);
    }

    public function removeCallBack(callback:Int->Int->Void)
    {
    	callbacks.remove(callback);
    }
}
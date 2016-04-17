package nebula.ecs.system;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;

import flixel.FlxSprite;
import flixel.util.FlxColor;

import nebula.ecs.component.ColourComponent;
import nebula.ecs.component.PositionComponent;
import nebula.ecs.node.ColourNode;
import nebula.NebulaState;

// Renders colours, sprites, and text. Split it out if it gets too fat.
class RenderSystem extends System
{
    public var state:NebulaState;
    private var colours:NodeList<ColourNode>;

    public function new(state:NebulaState)
    {
        super();
        this.state = state;
    }

    override public function addToEngine(engine:Engine):Void
    {
        colours = engine.getNodeList(ColourNode);
        trace('RS node list is ${colours}');
        for (node in colours)
        {
            addToDisplay(node);
        }
        colours.nodeAdded.add(addToDisplay);
        colours.nodeRemoved.add(removeFromDisplay);
    }

    private function addToDisplay(node:ColourNode):Void
    {
        trace("Node added: " + node);
        state.add(node.sprite);
    }

    private function removeFromDisplay(node:ColourNode):Void
    {
        state.remove(node.sprite);
    }

    override public function update(time:Float):Void
    {
        for (node in colours)
        {
            var sprite:FlxSprite = node.sprite;
            var colour:ColourComponent = node.colour;
            
            if (sprite == null)
            {
                sprite = new FlxSprite();
                var fColour:FlxColor = FlxColor.fromRGB(colour.red, colour.green, colour.blue);
                sprite.makeGraphic(colour.width, colour.height, fColour);            
            }
            
            var position:PositionComponent = node.position;

            sprite.x = position.x;
            sprite.y = position.y;
        }
    }

    override public function removeFromEngine(engine:Engine):Void
    {
        colours = null;
    }
}
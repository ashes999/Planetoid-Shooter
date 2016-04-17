package nebula.ecs.node;

import ash.core.Node;

import nebula.ecs.component.ColourComponent;
import nebula.ecs.component.PositionComponent;

import flixel.FlxSprite;

class ColourNode extends Node<ColourNode>
{
    public var position:PositionComponent;
    public var colour:ColourComponent;
    public var sprite:FlxSprite;
}
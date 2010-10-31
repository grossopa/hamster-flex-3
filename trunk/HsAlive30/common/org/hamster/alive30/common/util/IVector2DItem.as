package org.hamster.alive30.common.util
{
	public interface IVector2DItem
	{
		function set cx(value:Number):void;
		function get cx():Number;
		function set cy(value:Number):void;
		function get cy():Number;
		function get speedVector():Vector2D;
		function get accelVector():Vector2D;
		function onEnterFrameHandler(timeElapsed:Number):void;
	}
}
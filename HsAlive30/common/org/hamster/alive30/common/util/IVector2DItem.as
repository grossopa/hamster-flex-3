package org.hamster.alive30.common.util
{
	public interface IVector2DItem
	{
		function get speedVector():Vector2D;
		function get accelVector():Vector2D;
		function onEnterFrameHandler(timeElapsed:Number):void;
	}
}
package org.hamster.mapleCard.animations
{
	import flash.display.DisplayObject;
	
	import org.hamster.common.vector2d.Vector2D;

	public interface IAnimationControl
	{
		function set vector2D(value:Vector2D):void;
		function get vector2D():Vector2D;
		function control(object:DisplayObject):void;
	}
}
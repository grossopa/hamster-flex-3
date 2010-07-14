package org.hamster.mapleCard.animations
{
	import flash.display.DisplayObject;
	
	import org.hamster.common.vector2d.Vector2D;
	
	import spark.effects.animation.Animation;
	import spark.effects.animation.IAnimationTarget;
	
	public class SimpleAnimationControl implements IAnimationControl
	{
		private var _vector2D:Vector2D = new Vector2D();
		
		public function SimpleAnimationControl()
		{
		}
		
		public function set vector2D(value:Vector2D):void
		{
			_vector2D = value;
		}
		
		public function get vector2D():Vector2D
		{
			return _vector2D;
		}
		
		public function control(object:DisplayObject):void
		{
			object.x += _vector2D.x;
			object.y += _vector2D.y;
		}
	}
}
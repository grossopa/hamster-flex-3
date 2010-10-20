package org.hamster.alive30.common.util
{
	public class Vector2D
	{
		private var _x:Number;
		private var _y:Number;
		public function set x(value:Number):void { _x = value }
		public function get x():Number { return _x }
		public function set y(value:Number):void { _y = value }
		public function get y():Number { return _y }
		
		public function Vector2D(x:Number = 0, y:Number = 0)
		{
			this._x = x;
			this._y = y;
		}
	}
}
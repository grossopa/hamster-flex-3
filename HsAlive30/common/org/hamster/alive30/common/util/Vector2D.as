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
		
		public function set length(value:Number):void
		{
			var a:Number = angle;
			_x = Math.cos(a) * value;
			_y = Math.sin(a) * value;
		}
		
		public function get length():Number
		{
			return Math.sqrt(lengthSQ);
		}
		
		public function get lengthSQ():Number
		{
			return _x * _x + _y * _y;
		}
		
		public function set angle(value:Number):void
		{
			var len:Number = length;
			_x = Math.cos(value) * len;
			_y = Math.sin(value) * len;
		}
		
		public function get angle():Number
		{
			return Math.atan2(_y, _x);
		}
	}
}
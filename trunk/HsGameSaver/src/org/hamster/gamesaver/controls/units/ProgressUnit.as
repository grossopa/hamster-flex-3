package org.hamster.gamesaver.controls.units
{
	import mx.containers.Canvas;

	public class ProgressUnit extends Canvas
	{
		private var _progress:Number;
		
		public function ProgressUnit()
		{
			super();
		}
		
		public function set progress(value:Number):void
		{
			this._progress = value;
		}
		
		public function get progress():Number
		{
			return this._progress;	
		}
		
		
	}
}
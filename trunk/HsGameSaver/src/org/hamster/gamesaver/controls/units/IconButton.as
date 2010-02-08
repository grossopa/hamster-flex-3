package org.hamster.gamesaver.controls.units
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import mx.core.UIComponent;

	public class IconButton extends UIComponent
	{
		private var _normalIcon:Class;
		private var _downIcon:Class;
		private var _overIcon:Class;
		private var _disabledIcon:Class;
		
		protected var _currentClass:Class;
		
		public function set normalIcon(value:Class):void
		{
			this._normalIcon = value;
		}
		
		public function get normalIcon():Class
		{
			return this._normalIcon;
		}
		
		public function set downIcon(value:Class):void
		{
			this._downIcon = value;
		}
		
		public function get downIcon():Class
		{
			return this._downIcon;
		}
		
		public function set overIcon(value:Class):void
		{
			this._overIcon = value;
		}
		
		public function get overIcon():Class
		{
			return this._overIcon;
		}
		
		public function set disabledIcon(value:Class):void
		{
			this._disabledIcon = value;
		}
		
		public function get disabledIcon():Class
		{
			return this._disabledIcon;
		}
		
		public function IconButton()
		{
			super();
			
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		protected function rollOverHandler(evt:MouseEvent):void
		{
			this._currentClass = this.overIcon;
		}
		
		protected function rollOutHandler(evt:MouseEvent):void
		{
			this._currentClass = this.normalIcon;
		}
		
		protected function mouseDownHandler(evt:MouseEvent):void
		{
			this._currentClass = this.downIcon;
		}
		
		protected function mouseUpHandler(evt:MouseEvent):void
		{
			this._currentClass = this.normalIcon;
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			if (this.enabled) {
				if (this._currentClass == null) {
					this._currentClass = this.normalIcon;
				}

			}
			
			var bitmap:Bitmap = new _currentClass();
			var bd:BitmapData = bitmap.bitmapData;
			var matrix:Matrix = new Matrix();
			matrix.
			matrix.scale(uw / bd.width, uh / bd.height);
			this.graphics.beginBitmapFill(bd, matrix, false ,false);
			
			
		}
		
	}
}
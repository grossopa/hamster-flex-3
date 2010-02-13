package org.hamster.gamesaver.controls.base
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	import mx.core.UIComponent;

	public class BaseIconButton extends UIComponent
	{
		private static var _glowFilter:GlowFilter = new GlowFilter(0xFFFFFF, 0.7, 6, 6, 2, 3);
		
		private var _normalIcon:Class;
		private var _downIcon:Class;
		private var _overIcon:Class;
		private var _disabledIcon:Class;
		
		protected var _currentClass:Class;
		
		override public function set enabled(value:Boolean):void
		{
			this._currentClass = this.normalIcon;
			super.enabled = value;
		}
		
		public function set normalIcon(value:Class):void
		{
			this._normalIcon = value;
			this.invalidateDisplayList();
		}
		
		public function get normalIcon():Class
		{
			return this._normalIcon;
		}
		
		public function set downIcon(value:Class):void
		{
			this._downIcon = value;
			this.invalidateDisplayList();
		}
		
		public function get downIcon():Class
		{
			return this._downIcon;
			this.invalidateDisplayList();
		}
		
		public function set overIcon(value:Class):void
		{
			this._overIcon = value;
			this.invalidateDisplayList();
		}
		
		public function get overIcon():Class
		{
			return this._overIcon;
		}
		
		public function set disabledIcon(value:Class):void
		{
			this._disabledIcon = value;
			this.invalidateDisplayList();
		}
		
		public function get disabledIcon():Class
		{
			return this._disabledIcon;
		}
		
		public function BaseIconButton()
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
			if (this.enabled) {
				this.filters = [_glowFilter];
			}
			this.invalidateDisplayList();
		}
		
		protected function rollOutHandler(evt:MouseEvent):void
		{
			this._currentClass = this.normalIcon;
			this.filters = [];
			this.invalidateDisplayList();
		}
		
		protected function mouseDownHandler(evt:MouseEvent):void
		{
			this._currentClass = this.downIcon;
			this.invalidateDisplayList();
		}
		
		protected function mouseUpHandler(evt:MouseEvent):void
		{
			this._currentClass = this.normalIcon;
			this.invalidateDisplayList();
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			this.graphics.clear();
			
			if (!this.enabled) {
				this._currentClass = this.disabledIcon;
			}
			
			if (this._currentClass == null) {
				this._currentClass = this.normalIcon;
			}
			
			var bitmap:Bitmap = new _currentClass();
			var bd:BitmapData = bitmap.bitmapData;
			var matrix:Matrix = new Matrix();
			matrix.scale(uw / bd.width, uh / bd.height);
			this.graphics.beginBitmapFill(bd, matrix, false, true);
			this.graphics.drawRect(0, 0, uw, uh);
			this.graphics.endFill();
		}
		
	}
}
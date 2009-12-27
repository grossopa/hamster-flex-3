package noorg.magic.controls.common.buttons.base
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;

	public class BaseSimpleButton extends UIComponent
	{
		protected var _overImageClass:Class;
		protected var _normalImageClass:Class;
		protected var _downImageClass:Class;
		protected var _disabledImageClass:Class;
		
		protected var _overImage:Bitmap;
		protected var _normalImage:Bitmap;
		protected var _downImage:Bitmap;
		protected var _disabledImage:Bitmap;
		
		private var _drawMode:String;
		private var _isChanged:Boolean = true;
		
		protected function set overImage(value:Class):void
		{
			this._overImageClass = value;
			_overImage = new value();
		}
		
		protected function set normalImage(value:Class):void
		{
			this._normalImageClass = value;
			_normalImage = new value();			
		}
		
		protected function set downImage(value:Class):void
		{
			this._downImageClass = value;
			_downImage = new value();				
		}
		
		protected function set disabledImage(value:Class):void
		{
			this._disabledImageClass = value;
			_disabledImage = new value();				
		}
		
		public function BaseSimpleButton()
		{
			super();
			
			this.addEventListener(MouseEvent.ROLL_OVER, 	mouseEventHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, 		mouseEventHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, 	mouseEventHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, 		mouseEventHandler);
		}
		
		private function mouseEventHandler(evt:MouseEvent):void
		{
			_drawMode = evt.type;
			_isChanged = true;
			this.invalidateDisplayList();
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			if (_isChanged) {
				_isChanged = false;
			} else {
				return;
			}
			
			var g:Graphics = this.graphics;
			g.clear();
			
			if (this.enabled == false) {
				g.beginBitmapFill(this._disabledImage.bitmapData);
			} else if (this._drawMode == MouseEvent.ROLL_OVER) {
				g.beginBitmapFill(this._overImage.bitmapData);
			} else if (this._drawMode == MouseEvent.MOUSE_DOWN) {
				g.beginBitmapFill(this._downImage.bitmapData);
			} else {
				g.beginBitmapFill(this._normalImage.bitmapData);
			}
			
			g.drawRect(0, 0, uw, uh);
			g.endFill();
		}
		
	}
}
package org.hamster.magic.common.controls.items
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.core.ScrollPolicy;
	
	import org.hamster.magic.common.services.AssetService;

	public class MagicCircleItem extends Canvas
	{
		private static const AS:AssetService = AssetService.getInstance();
		
		private var _color:Number;
		private var _magicValue:int;
		private var _magicValueLabel:Label;	
		
		public function set color(value:Number):void
		{
			this._color = value;
			this.invalidateDisplayList();
		}
		
		public function get color():Number
		{
			return this._color;
		}
		
		public function set magicValue(value:int):void
		{
			this._magicValue = value;
			if (this.initialized) {
				_magicValueLabel.text = value.toString();
			}
			this.invalidateDisplayList();
		}
		
		public function get magicValue():int
		{
			return this._magicValue;
		}
		
		public function MagicCircleItem()
		{
			super();
			
			this.verticalScrollPolicy = ScrollPolicy.OFF;
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_magicValueLabel = new Label();
			_magicValueLabel.percentHeight = 100;
			_magicValueLabel.setStyle("horizontalCenter", 0);
			_magicValueLabel.setStyle("textAlign", "center");
			_magicValueLabel.setStyle("color", 0xFFFFFF);
			_magicValueLabel.setStyle("fontSize", 18);
		//	_magicValueLabel.setStyle("fontWeight", "bold");
			_magicValueLabel.setStyle("verticalAlign", "middle");
			_magicValueLabel.text = this.magicValue.toString();
			this.addChild(_magicValueLabel);
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			var bitmapData:BitmapData = new BitmapData(uw, uh, true);
			var baseCircle:Bitmap = new AS.BASE_CIRCLE();
			
			var bd:BitmapData = new BitmapData(baseCircle.width, baseCircle.height, false, this.color);
			bd.draw(baseCircle, null, null, BlendMode.ALPHA);
			baseCircle.bitmapData.draw(bd, null, null, BlendMode.OVERLAY);
			
			var m:Matrix = new Matrix();
			m.scale(uw / baseCircle.width, uh / baseCircle.height);
			
			this.graphics.beginBitmapFill(baseCircle.bitmapData, m, true, true);
			this.graphics.drawRect(0, 0, uw, uh);
			this.graphics.endFill();
		}
		
	}
}
package noorg.magic.controls.menus
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.ScrollPolicy;
	import mx.effects.Fade;
	import mx.effects.easing.Linear;
	
	import noorg.magic.utils.Constants;

	public class MagicMenuItem extends Canvas
	{
		public static const BG_DURATION:Number = 200;
		
		/**
		 * currently it's disabled.
		 */
		private var _hasLineBefore:Boolean;
		private var _hasLineAfter:Boolean;
		private var _bgImage:Image;
		private var _mainLabel:Label;
		private var _bgFade:Fade;
		private var _labelColor:Number = 0x000000;
		
		public var highlightColor:Number = 0xCA60FF;
		
		public var clickData:Object;
		public var clickFunction:Function;
		
		public function set labelColor(value:Number):void
		{
			_mainLabel.setStyle("color", this.labelColor);
		}
		
		public function get labelColor():Number
		{
			return _mainLabel.getStyle("color");
		}
		
		public function set hasLineBefore(value:Boolean):void
		{
		}
		
		public function get hasLineBefore():Boolean
		{
			return this._hasLineBefore;
		}
		
		public function set hasLineAfter(value:Boolean):void
		{
			this._hasLineAfter = value;
			validateHeight();
		}
		
		public function get hasLineAfter():Boolean
		{
			return this._hasLineAfter;
		}
		
		public function set text(value:String):void
		{
			_mainLabel.text = value;
		}
		
		public function get text():String
		{
			return _mainLabel.text;
		}
		
		private function validateHeight():void
		{
			if (hasLineAfter) {
				this.height = Constants.MENU_ITEM_HEIGHT + Constants.MENU_ITEM_LINE_HEIGHT;
			} else {
				this.height = Constants.MENU_ITEM_HEIGHT;
			}
		}
		
		public function MagicMenuItem()
		{
			super();
			this.height = Constants.MENU_ITEM_HEIGHT;
			this.width = Constants.MENU_ITEM_WIDTH;
			
			this.mouseChildren = false;
			
			this.verticalScrollPolicy = ScrollPolicy.OFF;
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			
			_bgFade = new Fade();
			_bgFade.easingFunction = Linear.easeNone;
			
			_mainLabel = new Label();
			_bgImage = new Image();
			
			this.labelColor = this._labelColor;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_bgImage.width = this.width;
			_bgImage.height = this.height;
			_bgImage.alpha = 0;
			var g:Graphics = _bgImage.graphics;
			g.beginFill(this.highlightColor, 1);
			g.drawRect(0, 0, _bgImage.width, _bgImage.height);
			g.endFill();
			this.addChild(_bgImage);
			
			
			_mainLabel.percentWidth = 100;
			_mainLabel.height = Constants.MENU_ITEM_HEIGHT;
			this.addChild(_mainLabel);
		}
		
		protected function rollOverHandler(evt:MouseEvent):void
		{
			_bgFade.stop();
			_bgFade.target = this._bgImage;
			_bgFade.alphaFrom = this._bgImage.alpha;
			_bgFade.alphaTo = 1;
			_bgFade.duration = (1 - this._bgImage.alpha) * BG_DURATION;
			_bgFade.play();
		}
		
		protected function rollOutHandler(evt:MouseEvent):void
		{
			_bgFade.stop();
			_bgFade.target = this._bgImage;
			_bgFade.alphaFrom = this._bgImage.alpha;
			_bgFade.alphaTo = 0;
			_bgFade.duration = this._bgImage.alpha * BG_DURATION;
			_bgFade.play();			
		}
		
		private function clickHandler(evt:MouseEvent):void
		{
			if (this.clickFunction != null) {
				clickFunction(this.clickData);
			}
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			var g:Graphics = this.graphics;
			
			g.clear();
			
			if (this.hasLineAfter) {
				g.lineStyle(1, 0x777777, 1);
				g.moveTo(0, Constants.MENU_ITEM_HEIGHT + 2);
				g.lineTo(uw, Constants.MENU_ITEM_HEIGHT + 2);
				
			}
		}
		
	}
}
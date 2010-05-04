package org.hamster.magic.play.controls.buttons
{
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.ScrollPolicy;
	import mx.effects.Glow;

	public class ConsoleNavButton extends Canvas
	{
		[Embed(source='/org/hamster/magic/play/assets/buttons/btn_nav_background.png')]
		private var NAV_BACKGROUND:Class;
		
		private var _selected:Boolean;
		private var _text:String;
		
		private var _mainBdImg:Image;
		private var _mainLabel:Label;
		
		private var _curGlow:Glow = new Glow();
		
		public function set text(value:String):void
		{
			this._text = value;
			if (this.initialized) {
				_mainLabel.text = value;
			}
		}
		
		public function get text():String
		{
			return this._text;
		}
		
		public function set selected(value:Boolean):void
		{
			if (this.initialized && value != this._selected) {
				this._selected = value;
				playSelectedEffect();
			}
		}
		
		public function get selected():Boolean
		{
			return this._selected;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_mainBdImg = new Image();
			_mainBdImg.source = NAV_BACKGROUND;
			_mainBdImg.setStyle('verticalCenter', 0);
			_mainBdImg.setStyle('horizontalCenter', 0);
			_mainBdImg.width = 80;
			_mainBdImg.height = 20;
			this.addChild(_mainBdImg);
			
			_mainLabel = new Label();
			_mainLabel.text = this.text;
			_mainLabel.setStyle('verticalCenter', 0);
			_mainLabel.setStyle('horizontalCenter', 0);
			_mainLabel.setStyle('fontSize', 12);
			_mainLabel.setStyle('fontWeight', 'bold');
			_mainLabel.setStyle('color', 0xFFFFFF);
			this.addChild(_mainLabel);
		}
		
		public function ConsoleNavButton()
		{
			super();
			
			this.width = 80;
			this.height = 20;
			
			this.verticalScrollPolicy = ScrollPolicy.OFF;
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			
			this.filters = [new DropShadowFilter(4, 45, 0x222222, 0.7, 4, 4, 2, 3)];
			
			this.addEventListener(MouseEvent.CLICK, mouseClickHandler);
		}
		
		protected function playSelectedEffect():void
		{
			if (_curGlow != null) {
				_curGlow.stop();
			}
			_curGlow.target = _mainBdImg;
			_curGlow.blurXFrom = 0;
			_curGlow.blurXTo = 5;
			_curGlow.blurYFrom = 0;
			_curGlow.blurYTo = 5;
			_curGlow.alphaFrom = 0;
			_curGlow.alphaTo = 1;
			_curGlow.color = 0xDFDFDF;
			_curGlow.duration = 250;
			_curGlow.play(null, !this.selected);
		}
		
		protected function mouseClickHandler(evt:MouseEvent):void
		{
			//this.selected = true;
		}
		
		
	}
}
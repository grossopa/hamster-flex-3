package org.hamster.alive30.menu.item
{
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.core.ScrollPolicy;
	import mx.effects.AnimateProperty;
	import mx.effects.Glow;
	import mx.effects.Move;
	import mx.effects.Parallel;
	
	public class MenuSelectionLabel extends Canvas
	{
		private var _mainLabel:Label;
		private var _parallel:Parallel;
		
		override public function set label(value:String):void
		{
			super.label = value;
			
			if (_mainLabel) {
				_mainLabel.text = value;
			}
		}
		
		public function MenuSelectionLabel()
		{
			super();
			this.verticalScrollPolicy = ScrollPolicy.OFF;
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			
			this.setStyle('backgroundColor', 0x000000);
			this.setStyle('backgroundAlpha', 0.01);
			this.buttonMode = true;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_mainLabel = new Label();
			_mainLabel.text = label;
			_mainLabel.x = 40;
			_mainLabel.setStyle('verticalCenter', 0);
			_mainLabel.setStyle('color', 0xFFFFFF);
			_mainLabel.setStyle('fontSize', 22);
			this.addChild(_mainLabel);
			
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			
			initializeAnimation();
		}
		
		private function initializeAnimation():void
		{
			_parallel = new Parallel();
			var move:Move = new Move(_mainLabel);
			move.xFrom = 40;
			move.xTo = 10;
			_parallel.addChild(move);
			var glow:Glow = new Glow(this);
			glow.alphaFrom = 0;
			glow.alphaTo = 0.5;
			glow.blurXFrom = 0;
			glow.blurXTo = 6;
			glow.blurXFrom = 0;
			glow.blurXTo = 6;
			glow.color = 0xFFFFFF;
			
			//_parallel.addChild(glow);
			
			_parallel.duration = 500;
		}
		
		private function rollOverHandler(evt:MouseEvent):void
		{
			if (_parallel.isPlaying) {
				_parallel.reverse();
			} else {
				_parallel.play();
			}
		}
		
		private function rollOutHandler(evt:MouseEvent):void
		{
			if (_parallel.isPlaying) {
				_parallel.reverse();
			} else {
				_parallel.play(null, true);
			}
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			this.graphics.clear();
			this.graphics.beginFill(0, 0.01);
			this.graphics.drawRect(0, 0, uw, uh);
			this.graphics.endFill();
		}
	}
}
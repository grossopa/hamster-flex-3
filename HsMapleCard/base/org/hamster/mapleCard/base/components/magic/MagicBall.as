package org.hamster.mapleCard.base.components.magic
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class MagicBall extends Sprite
	{
		private var speed:int = 3;
		private var count:int = 10;
		private var circlePoints:Array = new Array();
		
		public function MagicBall()
		{
			super();
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(evt:Event):void
		{
			drawSprites();
		}
		
		private function drawSprites():void
		{
			if (circlePoints.length == 0) {
				for (var i:int = 0; i < count; i++) {
					var point:Vector.<Number> = newRandomSpritePoint();
					this.circlePoints.push(point);
				}
			}
			
			var centerX:Number = this.width / 2;
			var centerY:Number = this.height / 2;
			for each (var point:Point in this.circlePoints) {
				
			}
			
			
		}
		
		private function newRandomSpritePoint():Vector.<Number>
		{
			var randomLength:Number = (this.width + this.height) * 2 * Math.random();
			
			var x:Number;
			var y:Number;
			var vx:Number;
			var vy:Number;
			var centerX:Number = this.width / 2;
			var centerY:Number = this.height / 2;
			
			if (randomLength < this.width) {
				x = randomLength;
				y = 0;
			} else if (randomLength > this.width && randomLength < this.width + this.height) {
				x = this.width;
				y = randomLength - this.width;
			} else if (randomLength > this.width + this.height && randomLength < this.width * 2 + this.height) {
				x = randomLength - this.width - this.height;
				y = this.height;
			} else {
				x = 0;
				y = randomLength - this.width * 2 - this.height;
			}
			
			vx = x - centerX
		}
	}
}
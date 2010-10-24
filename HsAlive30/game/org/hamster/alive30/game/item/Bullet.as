package org.hamster.alive30.game.item
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	
	import org.hamster.alive30.common.component.BaseImage;
	import org.hamster.alive30.common.util.IVector2DItem;
	import org.hamster.alive30.common.util.Vector2D;
	import org.hamster.alive30.game.util.GameConstants;
	import org.hamster.alive30.game.util.ResourceConstants;
	
	public class Bullet extends Sprite implements IVector2DItem
	{
		private const _speedVector:Vector2D = new Vector2D();
		private const _accelVector:Vector2D = new Vector2D();
		private var _type:String;
		private var _isAbsorbed:Boolean;
		
		public function set type(value:String):void
		{
			if (value != _type) {
				_type = value;
				if (this.numChildren > 0) {
					this.removeChildAt(0);
				}
				if (value == GameConstants.RED) {
					this.graphics.clear();
					this.graphics.beginFill(0xDD0000, 1);
					this.graphics.drawCircle(GameConstants.BULLET_HIT_RADIUS, 
						GameConstants.BULLET_HIT_RADIUS,
						GameConstants.BULLET_HIT_RADIUS - 5);
					//this.addChild(new ResourceConstants.IMG_RED_BALL());
				} else if (value == GameConstants.BLUE) {
					this.graphics.clear();
					this.graphics.beginFill(0x0098FF, 1);
					this.graphics.drawCircle(GameConstants.BULLET_HIT_RADIUS, 
						GameConstants.BULLET_HIT_RADIUS,
						GameConstants.BULLET_HIT_RADIUS - 5);
					//this.addChild(new ResourceConstants.IMG_BLUE_BALL());
				}
			}
		}
		public function get type():String { return _type }
		public function get speedVector():Vector2D { return _speedVector }
		public function get accelVector():Vector2D { return _accelVector }
		public function set isAbsorbed(value:Boolean):void { _isAbsorbed = value }
		public function get isAbsorbed():Boolean { return _isAbsorbed }
		
		public function Bullet()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			this.filters = [new GlowFilter(0x0098ff, 1, 5, 5, 2, 3)];
		}
	
		protected function addedToStageHandler(evt:Event):void
		{
			
		}
		
		protected function enterFrameHandler(evt:Event):void
		{
			
		}
	}
}
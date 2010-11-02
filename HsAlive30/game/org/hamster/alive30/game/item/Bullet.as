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
	import org.hamster.alive30.game.model.vo.BulletVO;
	import org.hamster.alive30.game.util.GameConstants;
	import org.hamster.alive30.game.util.ResourceConstants;
	
	public class Bullet extends Sprite implements IVector2DItem
	{
		private const _speedVector:Vector2D = new Vector2D();
		private const _accelVector:Vector2D = new Vector2D();
		private var _type:String;
		private var _moveType:String;
		private var _isAbsorbed:Boolean;
		
		private var _glowFilter:GlowFilter;
		
		public function set type(value:String):void
		{
			if (value != _type) {
				_type = value;
				if (this.numChildren > 0) {
					this.removeChildAt(0);
				}
				if (value == GameConstants.RED) {
					this.graphics.clear();
					_glowFilter.color = 0xDD0000;
					this.graphics.lineStyle(2, 0xDD0000, 0.4, false);
					this.graphics.drawCircle(GameConstants.BULLET_HIT_RADIUS, 
						GameConstants.BULLET_HIT_RADIUS,
						GameConstants.BULLET_HIT_RADIUS - 5);
					//this.addChild(new ResourceConstants.IMG_RED_BALL());
				} else if (value == GameConstants.BLUE) {
					this.graphics.clear();
					//this.graphics.beginFill(0x0098FF, 1);
					_glowFilter.color = 0x0098FF;
					this.graphics.lineStyle(2, 0x0098FF, 0.4, false);
					this.graphics.drawCircle(GameConstants.BULLET_HIT_RADIUS, 
						GameConstants.BULLET_HIT_RADIUS,
						GameConstants.BULLET_HIT_RADIUS - 5);
					//this.addChild(new ResourceConstants.IMG_BLUE_BALL());
				}
				this.filters = [];
			}
		}
		public function get type():String { return _type }
		public function set moveType(value:String):void { _moveType = value }
		public function get moveType():String { return _moveType }
		public function set cx(value:Number):void { x = value - (width >> 1) }
		public function get cx():Number { return x + (width >> 1) }
		public function set cy(value:Number):void { y = value - (height >> 1) }
		public function get cy():Number { return y + (height >> 1) }
		public function get speedVector():Vector2D { return _speedVector }
		public function get accelVector():Vector2D { return _accelVector }
		public function set isAbsorbed(value:Boolean):void { _isAbsorbed = value }
		public function get isAbsorbed():Boolean { return _isAbsorbed }
		
		public function Bullet()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			_glowFilter = new GlowFilter(0x0098ff, 1, 5, 5, 2, 3)
			//this.filters = [_glowFilter];
		}
	
		protected function addedToStageHandler(evt:Event):void
		{
			
		}
		
		public function onEnterFrameHandler(timeElapsed:Number):void
		{
			
		}
		
		public function applyVO(bulletVO:BulletVO):void
		{
			this.type = bulletVO.type;
			this.cx = bulletVO.cx;
			this.cy = bulletVO.cy;
			this.isAbsorbed = false;
			this.scaleX = 1;
			this.scaleY = 1;
			this.moveType = bulletVO.moveType;
			if (bulletVO.speedVector) {
				this.speedVector.x = bulletVO.speedVector.x;
				this.speedVector.y = bulletVO.speedVector.y;
			} else {
				this.speedVector.x = 0;
				this.speedVector.y = 0;
			}
			if (bulletVO.accelVector) {
				this.accelVector.x = bulletVO.accelVector.x;
				this.accelVector.y = bulletVO.accelVector.y;
			} else {
				this.accelVector.x = 0;
				this.accelVector.y = 0;
			}
		}
	}
}
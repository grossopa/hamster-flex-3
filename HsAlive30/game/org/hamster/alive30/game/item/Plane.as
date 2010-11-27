package org.hamster.alive30.game.item
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.effects.AnimateProperty;
	import mx.effects.Effect;
	import mx.effects.Fade;
	import mx.effects.Parallel;
	import mx.effects.Zoom;
	
	import org.hamster.alive30.common.component.BaseImage;
	import org.hamster.alive30.common.util.IVector2DItem;
	import org.hamster.alive30.common.util.Vector2D;
	import org.hamster.alive30.game.util.GameConstants;
	import org.hamster.alive30.game.util.ResourceConstants;
	
	public class Plane extends Sprite implements IVector2DItem
	{
		private const _speedVector:Vector2D = new Vector2D();
		private const _accelVector:Vector2D = new Vector2D();
		
		private var PLANE_OUTER_RED:Sprite = new ResourceConstants.PLANE_SHIELD_RED();
		private var PLANE_OUTER_BLUE:Sprite = new ResourceConstants.PLANE_SHIELD_BLUE();
		private var PLANE_OUTER_R2B:Sprite = new ResourceConstants.PLANE_SHIELD_R2B();
		private var PLANE_OUTER_B2R:Sprite = new ResourceConstants.PLANE_SHIELD_B2R();
		
		private var _type:String;
		private var _currentOuter:DisplayObject;
		
		private var _changeTypeTimeCount:Number = 0;
		
		public function set type(value:String):void
		{
			if (_type != value && _changeTypeTimeCount <= 0) {
				_type = value;
				_changeTypeTimeCount = GameConstants.PLANE_ALL_CHANGE_TYPE_TIME;
			}
		}
		
		public function get type():String
		{
			return _type;
		}
		public function set cx(value:Number):void { x = value - (width >> 1) }
		public function get cx():Number { return x + (width >> 1) }
		public function set cy(value:Number):void { y = value - (height >> 1) }
		public function get cy():Number { return y + (height >> 1) }
		public function get speedVector():Vector2D { return _speedVector }
		public function get accelVector():Vector2D { return _accelVector }
		
		public function get isChangingType():Boolean
		{
			return _changeTypeTimeCount >= GameConstants.PLANE_TYPE_COOL_DOWN_TIME;
		}
		
		public function Plane()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			var bm:Bitmap = new ResourceConstants.IMG_PLANE();
			this.addChild(bm);
			_currentOuter = this.addChildAt(PLANE_OUTER_BLUE, 0);
		}
		
		private function addedToStageHandler(evt:Event):void
		{
			
		}
		
		public function onEnterFrameHandler(timeElapsed:Number):void
		{
			if (_changeTypeTimeCount > 0) {
				animateOuter(timeElapsed);
			}
		}
		
		public function animateOuter(timeElapsed:Number):void
		{
			var oneAniTime:Number = (GameConstants.PLANE_CHANGE_TYPE_TIME >> 1);
			var timeFlag1:Number = GameConstants.PLANE_TYPE_COOL_DOWN_TIME 
				+ oneAniTime;
			
			if (_changeTypeTimeCount > timeFlag1) {
				_changeTypeTimeCount -= timeElapsed;
				if (_changeTypeTimeCount <= timeFlag1) {
					_currentOuter = this.removeChild(_currentOuter);
					if (type == GameConstants.BLUE) {
						_currentOuter = PLANE_OUTER_BLUE;
					} else if (type == GameConstants.RED) {
						_currentOuter = PLANE_OUTER_RED;
					}
					this.addChild(_currentOuter);
				}
			} else {
				_changeTypeTimeCount -= timeElapsed;
			}
			var percent:Number;
			if (_changeTypeTimeCount > timeFlag1) {
				percent = (oneAniTime - GameConstants.PLANE_ALL_CHANGE_TYPE_TIME 
					+ _changeTypeTimeCount) / oneAniTime;
				
			} else if (_changeTypeTimeCount <= timeFlag1 
				&& _changeTypeTimeCount > GameConstants.PLANE_TYPE_COOL_DOWN_TIME) {
				percent = (oneAniTime - _changeTypeTimeCount + GameConstants.PLANE_TYPE_COOL_DOWN_TIME) / oneAniTime;
			} else {
				percent = 1;
			}
			
			_currentOuter.scaleX = percent;
			_currentOuter.scaleY = percent;
			_currentOuter.x = (1 - percent) * (this.width >> 1);
			_currentOuter.y = (1 - percent) * (this.height >> 1);
		}
	}
}
package org.hamster.alive30.game.item
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.hamster.alive30.common.component.BaseImage;
	import org.hamster.alive30.common.util.IVector2DItem;
	import org.hamster.alive30.common.util.Vector2D;
	import org.hamster.alive30.game.util.GameConstants;
	import org.hamster.alive30.game.util.ResourceConstants;
	
	public class Plane extends Sprite implements IVector2DItem
	{
		private const _speedVector:Vector2D = new Vector2D();
		private const _accelVector:Vector2D = new Vector2D();
		
		private var _type:String;
		private var _currentOuter:Object;
		
		public function set type(value:String):void
		{
			if (_type != value) {
				_type = value;
				if (numChildren > 1) {
					this.removeChildAt(0);
				}
				if (_type == GameConstants.BLUE) {
					this.addChildAt(new ResourceConstants.PLANE_OUTER_BLUE(), 0);
				} else if (_type == GameConstants.RED) {
					this.addChildAt(new ResourceConstants.PLANE_OUTER_RED(), 0);
				}
			}
		}
		
		public function get type():String
		{
			return _type;
		}
		public function get speedVector():Vector2D { return _speedVector }
		public function get accelVector():Vector2D { return _accelVector }
		
		public function Plane()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			var bm:Bitmap = new ResourceConstants.IMG_PLANE();
			this.addChild(bm);
		}
		
		private function addedToStageHandler(evt:Event):void
		{
			
		}
		
		
		
		
	}
}
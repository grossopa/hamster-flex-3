package org.hamster.imageCropper
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class HsImageCropperEvent extends Event
	{
		public static const M_DOWN:String = "mDown";
		public static const M_UP:String = "mUp";
		public static const SELECTION_CHANGE:String = "selectionChange";
		public static const SOURCE_CHANGE:String = "sourceChange";
		
		public var mouseDownX:Number;
		public var mouseDownY:Number;
		
		public var selectionArea:Rectangle;
		
		public function HsImageCropperEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:HsImageCropperEvent = new HsImageCropperEvent(type, bubbles, cancelable);
			result.mouseDownX = mouseDownX;
			result.mouseDownY = mouseDownY;
			result.selectionArea = selectionArea.clone();
			return result;
		}
	}
}
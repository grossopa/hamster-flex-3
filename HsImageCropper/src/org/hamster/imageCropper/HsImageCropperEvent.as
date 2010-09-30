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
		
		public var mouseX:Number;
		public var mouseY:Number;
		
		public var selectionArea:Rectangle;
		
		public function HsImageCropperEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:HsImageCropperEvent = new HsImageCropperEvent(type, bubbles, cancelable);
			result.mouseX = mouseX;
			result.mouseY = mouseY;
			result.selectionArea = selectionArea.clone();
			return result;
		}
		
		override public function toString():String
		{
			return "{'HsImageCropperEvent':{'type':'"
				+ type + "','mouseX':'"
				+ mouseX + "','mouseY':'"
				+ mouseY + "','selectionArea':'"
				+ selectionArea.toString() + "'}}";
		}
	}
}
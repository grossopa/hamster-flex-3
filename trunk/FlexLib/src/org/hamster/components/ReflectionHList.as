package org.hamster.components
{
	import flash.display.DisplayObject;
	
	import mx.containers.Canvas;

	/**
	 * not available yet.
	 * 
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 */
	public class ReflectionHList extends Canvas
	{
		public var gap:Number = 5;
		public var marginLeft:Number = 0;
		public var marginTop:Number = 0;
		
		public function AdvancedHList()
		{
			super();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(createRefCanvas(child));
			refreshChildLocation();
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			for each (var refCanvas:ReflectionCanvas in this.getChildren()) {
				if (refCanvas.mainDisObj == child) {
					var child:DisplayObject = super.removeChild(child);
					refreshChildLocation();
					return child;
				}
			}
			return null;
		}
		
		private function refreshChildLocation():void
		{
			var nextX = 0;
			for each(var refCanvas:ReflectionCanvas in this.getChildren()) {
				refCanvas.x = nextX;
				refCanvas.y = marginTop;
				refCanvas.paintReflection();
				nextX += disObj.width + gap;
			}
		}
		
		private function createRefCanvas(disObj:DisplayObject):ReflectionCanvas
		{
			var result:ReflectionCanvas = new ReflectionCanvas();
			result.mainDisObj = child;
			return result;
		}
		
		
	}
}
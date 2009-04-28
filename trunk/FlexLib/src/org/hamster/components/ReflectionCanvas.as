package org.hamster.components
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	
	import org.hamster.utils.ImageUtil;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 */

	public class ReflectionCanvas extends Canvas
	{
		private const mainImage:Image = new Image();
		private const reflection:Image = new Image();
		private var disObj:DisplayObject;
		public var gap:uint = 5;
		
		public function set mainDisObj(disObj:DisplayObject):void
		{
			this.disObj = disObj;
		}
		
		public function get mainDisObj():DisplayObject
		{
			return this.disObj;
		}
		
		public function ReflectionCanvas()
		{
			super();
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";
			this.addChild(mainImage);
			this.addChild(reflection);
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
		}
		
		public function paintReflection():void
		{
			mainImage.width = this.width;
			mainImage.height = disObj.height / disObj.width * this.width;
			reflection.width = mainImage.width;
			reflection.height = mainImage.height;
			reflection.y = mainImage.height + gap;
			mainImage.source = ImageUtil.toImage(disObj).source;
			var tm:Matrix = new Matrix(1, 0, 0, -1, 0, disObj.height);
			reflection.source = ImageUtil.fadeImage(
					disObj, tm, Math.PI * 1.5, [0, 0.3], [0, 255]).source;
		}
		
	}
}
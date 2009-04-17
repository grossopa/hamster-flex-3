package org.hamster.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.controls.Image;
	
	public class ImageUtil
	{
		public static function toImage(displayObject:DisplayObject):Image
		{
			var bd:BitmapData = new BitmapData(
					displayObject.width, displayObject.height);
			bd.draw(displayObject);
			var bm:Bitmap = new Bitmap(bd);
			var im:Image = new Image();
			im.width = displayObject.width;
			im.height = displayObject.height;
			im.source = bm;
			return im;
		}
		
		public static function splitImage(
				image:Image, rect:Rectangle, destPoint:Point):Image
		{
			var result:Image = new Image();
			var bd:BitmapData = new BitmapData(rect.width, rect.height);
			bd.copyPixels(image.source.bitmapData, rect, destPoint);
			result.width = rect.width;
			result.height = rect.height;
			result.source = new Bitmap(bd);
			return result;
		}
		
		// TODO: bitmapData support
		public static function fadeImage(target:DisplayObject, targetMatrix:Matrix = null,
			pi:Number = 0, alphas:Array = null, ratios:Array = null):Image
		{
			if(alphas == null || alphas.length == 0) alphas = [0, 1];
			if(ratios == null || ratios.length == 0) ratios = [0, 255];
			var colors:Array = new Array(alphas.length);
			for (var i:int = 0; i < colors.length; i++) {
				colors[i] = 0;
			}
			
			var bd:BitmapData = new BitmapData(target.width, target.height);
			bd.draw(target);
			var temp:BitmapData = new BitmapData(target.width, target.height);
			temp.draw(bd, targetMatrix);
			var shape:Shape = new Shape();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(target.width, target.height, pi); 
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors,
					alphas, ratios, gradientMatrix);
			shape.graphics.drawRect(0, 0, target.width, target.height);
			shape.graphics.endFill();
			temp.draw(shape, null, null, BlendMode.ALPHA);
			
			var result:Image = new Image();
			result.source = new Bitmap(temp);
			return result;
		}
	}
}
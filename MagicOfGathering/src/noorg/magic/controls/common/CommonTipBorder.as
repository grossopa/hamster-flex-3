package noorg.magic.controls.common
{
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import mx.skins.Border;
	import mx.skins.halo.ApplicationBackground;
	import mx.utils.GraphicsUtil;
	
	import noorg.magic.utils.TipArrowUtil;
	
	public class CommonTipBorder extends Border
	{
		public function CommonTipBorder()
		{
			super();
			var ddd:ApplicationBackground
		}
		
		private var tipWidth:Number;
		private var tipheight:Number;
		private var tipDistanceLeft:Number;
		private var tipDistanceTop:Number;
		private var tipDistanceRight:Number;
		private var tipDistanceBottom:Number;
		private var directions:uint;
		
		override protected function drawRoundRect(x:Number, y:Number,
												  width:Number, height:Number, 
												  cornerRadius:Object=null, 
												  color:Object=null, alpha:Object=null, 
												  gradientMatrix:Matrix=null, 
												  gradientType:String=linear,
												  gradientRatios:Array=null, hole:Object=null):void
		{
			super.drawRoundRect(
			var g:Graphics = graphics;

			// Quick exit if weight or height is zero.
			// This happens when scaling a component to a very small value,
			// which then gets rounded to 0.
			if (width == 0 || height == 0)
				return;
	
			// If color is an object then allow for complex fills.
			if (color !== null)
			{
				if (color is uint)
				{
					g.beginFill(uint(color), Number(alpha));
				}
				else if (color is Array)
				{
					var alphas:Array = alpha is Array ?
									   alpha as Array :
									   [ alpha, alpha ];
	
					if (!gradientRatios)
						gradientRatios = [ 0, 0xFF ];
	
					g.beginGradientFill(gradientType,
										color as Array, alphas,
										gradientRatios, gradientMatrix);
				}
			}
	
			var ellipseSize:Number;
	
			// Stroke the rectangle.
			if (!cornerRadius)
			{
				// g.drawRect(x, y, width, height);
				TipArrowUtil.drawTipRect(g, x, y, width, height, 
						tipWidth, tipHeight,
						tipDistanceLeft, tipDistanceTop, tipDistanceRight, tipDistanceBottom,
						directions);
			}
			else if (cornerRadius is Number)
			{
				ellipseSize = Number(cornerRadius) * 2;
				g.drawRoundRect(x, y, width, height, 
								ellipseSize, ellipseSize);
			}
			else
			{
				GraphicsUtil.drawRoundRectComplex(g,
									   x, y, width, height,
									   cornerRadius.tl, cornerRadius.tr,
									   cornerRadius.bl, cornerRadius.br);
			}
	
			// Carve a rectangular hole out of the middle of the rounded rect.
			if (hole)
			{
				var holeR:Object = hole.r;
				if (holeR is Number)
				{
					ellipseSize = Number(holeR) * 2;
					g.drawRoundRect(hole.x, hole.y, hole.w, hole.h, 
									ellipseSize, ellipseSize);
				}
				else
				{
					GraphicsUtil.drawRoundRectComplex(g,
										   hole.x, hole.y, hole.w, hole.h,
										   holeR.tl, holeR.tr, holeR.bl, holeR.br);
				}	
			}
	
			if (color !== null)
				g.endFill();
			}
		}
	}
}
package noorg.magic.utils
{
	import flash.display.Graphics;
	
	import mx.skins.RectangularBorder;
	
	public class CommonGraphicsUtil
	{
		public static const LEFT:uint = 0x0001;
		public static const TOP:uint = 0x0010;
		public static const RIGHT:uint = 0x0100;
		public static const BOTTOM:uint = 0X1000;
		
		public function CommonGraphicsUtil()
		{
		}
		
		/**
		 * @g Graphics Object
		 * @x
		 * @y
		 * @width
		 * @height
		 * @tipWidth
		 * @tipHeight
		 * @tipDistanceLeft paddingTop of tips in LEFT
		 * @tipDistanceTop paddingLeft of tips in TOP
		 * @tipDistanceRight paddingTop of tips in RIGHT
		 * @tipDistanceBottom paddingLeft of tips in BOTTOM
		 * @directions LEFT|TOP|RIGHT|BOTTOM, we can have more than one tip arrow
		 * 
		 */
		public static function drawTipRect(g:Graphics, x:Number, y:Number, 
									width:Number, height:Number, 
									tipWidth:Number, tipHeight:Number,
									tipDistanceLeft:Number, tipDistanceTop:Number,
									tipDistanceRight:Number, tipDistanceBottom:Number,
									directions:uint):void
		{
			var ddd:RectangularBorder
			var isLeft:Boolean 		= (LEFT 	& directions) != 0;
			var isTop:Boolean 		= (TOP 		& directions) != 0;
			var isRight:Boolean 	= (RIGHT 	& directions) != 0;
			var isBottom:Boolean 	= (BOTTOM 	& directions) != 0;
			
			// ensure tip width & height is not larger than width & height
			// ingore first
//			if (tipDistanceTop + tipWidth > width) {
//				tipWidth = width - tipDistanceTop;
//			}
//			
//			if (tipDistanceBottom + tipWidth > width) {
//				tipWidth = width - tipDistanceBottom;
//			}
//			
//			if (tipDistanceLeft + tipHeight > height) {
//				tipHeight = height - tipDistanceLeft;
//			}
//			
//			if (tipDistanceRight + tipHeight > height) {
//				tipHeight = height - tipDistanceRight;
//			}
			
			var ltx:Number = isLeft 	? x + tipHeight 			: x;
			var lty:Number = isTop 		? y + tipHeight 			: y;
			var rtx:Number = isRight 	? x + width - tipHeight 	: x + width;
			var rty:Number = lty;
			var rbx:Number = rtx;
			var rby:Number = isBottom 	? y + height - tipHeight 	: y + height;
			var lbx:Number = ltx;
			var lby:Number = rby;
			
			g.moveTo(ltx, lty);
			
			if (isTop) {
				g.lineTo(x + tipDistanceTop, 				y + tipHeight);
				g.lineTo(x + tipDistanceTop + tipWidth / 2, y);
				g.lineTo(x + tipDistanceTop + tipWidth, 	y + tipHeight);
			}
			
			g.lineTo(rtx, rty);
			
			if (isRight) {
				g.lineTo(x + width - tipHeight, y + tipDistanceRight);
				g.lineTo(x + width, 			y + tipDistanceRight + tipWidth / 2);
				g.lineTo(x + width - tipHeight, y + tipDistanceRight + tipWidth);
			}
			
			g.lineTo(rbx, rby);
			
			if (isBottom) {
				g.lineTo(x + tipDistanceBottom + tipWidth, 		y + height - tipHeight);
				g.lineTo(x + tipDistanceBottom + tipWidth / 2, 	y + height);
				g.lineTo(x + tipDistanceBottom, 				y + height - tipHeight);
			}
			
			g.lineTo(lbx, lby);
			
			if (isLeft) {
				g.lineTo(x + tipHeight, y + tipDistanceLeft + tipWidth);
				g.lineTo(x, 			y + tipDistanceLeft + tipWidth / 2);
				g.lineTo(x + tipHeight, y + tipDistanceLeft);
			}
			
			g.lineTo(ltx, lty);
			
		}
		
		/**
		 * Extends from GraphicUtil.drawRountRectComplex
	     *
	     */
		public static function drawTipRoundRectComplex(g:Graphics, x:Number, y:Number, 
								  width:Number, height:Number, 
	                              topLeftRadius:Number, topRightRadius:Number, 
	                              bottomLeftRadius:Number, bottomRightRadius:Number,
	                              tipWidth:Number, tipHeight:Number,
								  tipDistanceLeft:Number, tipDistanceTop:Number,
								  tipDistanceRight:Number, tipDistanceBottom:Number,
								  directions:uint):void
		{
			
			var isLeft:Boolean 		= (LEFT 	& directions) != 0;
			var isTop:Boolean 		= (TOP 		& directions) != 0;
			var isRight:Boolean 	= (RIGHT 	& directions) != 0;
			var isBottom:Boolean 	= (BOTTOM 	& directions) != 0;
			
			
			var xw:Number = x + width;
			var yh:Number = y + height;
	
			// Make sure none of the radius values are greater than w/h.
			// These are all inlined to avoid function calling overhead
			var minSize:Number = width < height ? width * 2 : height * 2;
			topLeftRadius = topLeftRadius < minSize ? topLeftRadius : minSize;
			topRightRadius = topRightRadius < minSize ? topRightRadius : minSize;
			bottomLeftRadius = bottomLeftRadius < minSize ? bottomLeftRadius : minSize;
			bottomRightRadius = bottomRightRadius < minSize ? bottomRightRadius : minSize;
	
			var ltx:Number = isLeft 	? x + tipHeight 			: x;
			var lty:Number = isTop 		? y + tipHeight 			: y;
			var rtx:Number = isRight 	? x + width - tipHeight 	: x + width;
			var rty:Number = lty;
			var rbx:Number = rtx;
			var rby:Number = isBottom 	? y + height - tipHeight 	: y + height;
			var lbx:Number = ltx;
			var lby:Number = rby;
			
			// Math.sin and Math,tan values for optimal performance.
			// Math.rad = Math.PI / 180 = 0.0174532925199433
			// r * Math.sin(45 * Math.rad) =  (r * 0.707106781186547);
			// r * Math.tan(22.5 * Math.rad) = (r * 0.414213562373095);
			//
			// We can save further cycles by precalculating
			// 1.0 - 0.707106781186547 = 0.292893218813453 and
			// 1.0 - 0.414213562373095 = 0.585786437626905
	
			// bottom-right corner
			var a:Number = bottomRightRadius * 0.292893218813453;		// radius - anchor pt;
			var s:Number = bottomRightRadius * 0.585786437626905; 	// radius - control pt;
			g.moveTo(rbx, rby - bottomRightRadius);
			g.curveTo(rbx, rby - s, rbx - a, rby - a);
			g.curveTo(rbx - s, rby, rbx - bottomRightRadius, rby);
	
			// draw bottom
			a = bottomLeftRadius * 0.292893218813453;
			s = bottomLeftRadius * 0.585786437626905;
			
			if (isBottom) {
				g.lineTo(lbx + bottomLeftRadius + tipDistanceBottom + tipWidth, 	lby);
				g.lineTo(lbx + bottomLeftRadius + tipDistanceBottom + tipWidth / 2, lby + tipHeight);
				g.lineTo(lbx + bottomLeftRadius + tipDistanceBottom, 				lby);
			}
			g.lineTo(lbx + bottomLeftRadius, lby);
			
			// bottom-left corner
			a = bottomLeftRadius * 0.292893218813453;
			s = bottomLeftRadius * 0.585786437626905;
			
			g.curveTo(lbx + s, lby,     lbx + a, lby - a);
			g.curveTo(lbx, 	   lby - s, lbx,     lby - bottomLeftRadius);
			
			// draw left
			if (isLeft) {
				g.lineTo(lbx, 			  lty + topLeftRadius + tipDistanceLeft + tipWidth);
				g.lineTo(lbx - tipHeight, lty + topLeftRadius + tipDistanceLeft + tipWidth / 2);
				g.lineTo(lbx, 			  lty + topLeftRadius + tipDistanceLeft);
			}
			g.lineTo(ltx, lty + topLeftRadius);		
	
			// top-left corner
			a = topLeftRadius * 0.292893218813453;
			s = topLeftRadius * 0.585786437626905;
			
			g.curveTo(ltx, lty + s, ltx + a, lty + a);
			g.curveTo(ltx + s, lty, ltx + topLeftRadius, lty);
			
			// draw top
			if (isTop) {
				g.lineTo(ltx + topLeftRadius + tipDistanceTop, 				  lty);
				g.lineTo(ltx + topLeftRadius + tipDistanceTop + tipWidth / 2, lty - tipHeight);
				g.lineTo(ltx + topLeftRadius + tipDistanceTop + tipWidth, 	  lty);
			}
			g.lineTo(rtx - topRightRadius, rty);
	
			// top-right corner
			a = topRightRadius * 0.292893218813453;
			s = topRightRadius * 0.585786437626905;
			
			g.curveTo(rtx - s, rty, rtx - a, rty + a);
			g.curveTo(rtx, rty + s, rtx, rty + topRightRadius);
			
			// draw right
			
			if (isRight) {
				g.lineTo(rtx, 				rty + topRightRadius + tipDistanceRight);
				g.lineTo(rtx + tipHeight, 	rty + topRightRadius + tipDistanceRight + tipWidth / 2);
				g.lineTo(rtx, 				rty + topRightRadius + tipDistanceRight + tipWidth);
			}
			g.lineTo(rbx, rby - bottomRightRadius);
		}

	}
}
package org.hamster.graphics.tip
{
	import flash.display.Graphics;
	
	/**
	 * clockwised drawing sequence.
	 */
	public class TipUtil
	{
		public static const LEFT:uint = 0x0001;
		public static const TOP:uint = 0x0010;
		public static const RIGHT:uint = 0x0100;
		public static const BOTTOM:uint = 0X1000;
		
		public function TipUtil()
		{
		}
		
		/**
		 * 
		 */
		public static function drawTipRect(g:Graphics, x:Number, y:Number, 
									width:Number, height:Number,
									iTipArrowArray:Array, inside:Boolean = true):void
		{
			var isLeft:Boolean;
			var isTop:Boolean;
			var isRight:Boolean;
			var isBottom:Boolean;
			var iTipArrow:ITipArrow;
			
			// firstly, we should find the max height and detect directions
			var tipHeight:Number = 0;
			for each (iTipArrow in iTipArrowArray) {
				tipHeight = Math.max(tipHeight, iTipArrow.tipHeight);
				isLeft   = isLeft   || (iTipArrow.arrowDirection == LEFT);
				isTop    = isTop    || (iTipArrow.arrowDirection == TOP);
				isRight  = isRight  || (iTipArrow.arrowDirection == RIGHT);
				isBottom = isBottom || (iTipArrow.arrowDirection == BOTTOM);
			}			
			
			// ensure tip width & height is not larger than width & height
			// TODO
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
			
			
			// define the positions
			var ltx:Number = isLeft   && inside ? x + tipHeight 		 : x;
			var lty:Number = isTop 	  && inside ? y + tipHeight 		 : y;
			var rtx:Number = isRight  && inside ? x + width - tipHeight  : x + width;
			var rty:Number = lty;
			var rbx:Number = rtx;
			var rby:Number = isBottom && inside ? y + height - tipHeight : y + height;
			var lbx:Number = ltx;
			var lby:Number = rby;
			
			var sx:Number;
			var sy:Number;
			var ex:Number;
			var ey:Number;
			
			// go to start point
			g.moveTo(ltx, lty);
			
			// draw top
			for each (iTipArrow in iTipArrowArray) {
				if (iTipArrow.arrowDirection == TOP) {
					sx = x + iTipArrow.distanceA;
					sy = lty;
					ex = x + iTipArrow.distanceB;
					ey = lty;
					g.lineTo(sx, sy);
					iTipArrow.drawTip(g, sx, sy, ex, ey);
					g.lineTo(ex, ey);
				}
			}
			g.lineTo(rtx, rty);
			
			// draw right
			for each (iTipArrow in iTipArrowArray) {
				if (iTipArrow.arrowDirection == RIGHT) {
					sx = rtx;
					sy = y + iTipArrow.distanceA;
					ex = rtx;
					ey = y + iTipArrow.distanceB;
					g.lineTo(sx, sy);
					iTipArrow.drawTip(g, sx, sy, ex, ey);
					g.lineTo(ex, ey);
				}
			}
			g.lineTo(rbx, rby);
			
			// draw bottom
			for each (iTipArrow in iTipArrowArray) {
				if (iTipArrow.arrowDirection == BOTTOM) {
					sx = x + iTipArrow.distanceB;
					sy = lby;
					ex = x + iTipArrow.distanceA;
					ey = lby;
					g.lineTo(sx, sy);
					iTipArrow.drawTip(g, sx, sy, ex, ey);
					g.lineTo(ex, ey);
				}
			}
			g.lineTo(lbx, lby);
			
			// draw left
			for each (iTipArrow in iTipArrowArray) {
				if (iTipArrow.arrowDirection == LEFT) {
					sx = lbx;
					sy = y + iTipArrow.distanceB;
					ex = lbx;
					ey = y + iTipArrow.distanceA;
					g.lineTo(sx, sy);
					iTipArrow.drawTip(g, sx, sy, ex, ey);
					g.lineTo(ex, ey);
				}
			}
			g.lineTo(ltx, lty);
			
		}
		
		/**
		 * Extends from GraphicUtil.drawRountRectComplex
	     *
	     */
		public static function drawTipRoundRectComplex(g:Graphics, x:Number, y:Number, 
								  width:Number, height:Number, iTipArrowArray:Array,
	                              topLeftRadius:Number, topRightRadius:Number, 
	                              bottomLeftRadius:Number, bottomRightRadius:Number,
	                              inside:Boolean = true):void
		{
			
			var isLeft:Boolean;
			var isTop:Boolean;
			var isRight:Boolean;
			var isBottom:Boolean;
			var tipHeight:Number = 0;
			
			for each (iTipArrow in iTipArrowArray) {
				tipHeight = Math.max(tipHeight, iTipArrow.tipHeight);
				isLeft   = isLeft   || (iTipArrow.arrowDirection == LEFT);
				isTop    = isTop    || (iTipArrow.arrowDirection == TOP);
				isRight  = isRight  || (iTipArrow.arrowDirection == RIGHT);
				isBottom = isBottom || (iTipArrow.arrowDirection == BOTTOM);
			}	
			
			var sx:Number;
			var sy:Number;
			var ex:Number;
			var ey:Number;
			var iTipArrow:ITipArrow;
			
			// Make sure none of the radius values are greater than w/h.
			// These are all inlined to avoid function calling overhead
			var minSize:Number = width < height ? width * 2 : height * 2;
			topLeftRadius = topLeftRadius < minSize ? topLeftRadius : minSize;
			topRightRadius = topRightRadius < minSize ? topRightRadius : minSize;
			bottomLeftRadius = bottomLeftRadius < minSize ? bottomLeftRadius : minSize;
			bottomRightRadius = bottomRightRadius < minSize ? bottomRightRadius : minSize;
	
			// define the positions
			var ltx:Number = isLeft   && inside ? x + tipHeight 		 : x;
			var lty:Number = isTop 	  && inside ? y + tipHeight 		 : y;
			var rtx:Number = isRight  && inside ? x + width - tipHeight  : x + width;
			var rty:Number = lty;
			var rbx:Number = rtx;
			var rby:Number = isBottom && inside ? y + height - tipHeight : y + height;
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
			for each (iTipArrow in iTipArrowArray) {
				if (iTipArrow.arrowDirection == BOTTOM) {
					sx = x + iTipArrow.distanceB;
					sy = rby;
					ex = x + iTipArrow.distanceA;
					ey = rby;
					g.lineTo(sx, sy);
					iTipArrow.drawTip(g, sx, sy, ex, ey);
					g.lineTo(ex, ey);
				}
			}
			g.lineTo(lbx + bottomLeftRadius, lby);
			
			// bottom-left corner
			a = bottomLeftRadius * 0.292893218813453;
			s = bottomLeftRadius * 0.585786437626905;
			
			g.curveTo(lbx + s, lby,     lbx + a, lby - a);
			g.curveTo(lbx, 	   lby - s, lbx,     lby - bottomLeftRadius);
			
			// draw left
			for each (iTipArrow in iTipArrowArray) {
				if (iTipArrow.arrowDirection == LEFT) {
					sx = lbx;
					sy = y + iTipArrow.distanceB;
					ex = lbx;
					ey = y + iTipArrow.distanceA;
					g.lineTo(sx, sy);
					iTipArrow.drawTip(g, sx, sy, ex, ey);
					g.lineTo(ex, ey);
				}
			}
			g.lineTo(ltx, lty + topLeftRadius);		
	
			// top-left corner
			a = topLeftRadius * 0.292893218813453;
			s = topLeftRadius * 0.585786437626905;
			
			g.curveTo(ltx, 	   lty + s, ltx + a,             lty + a);
			g.curveTo(ltx + s, lty,     ltx + topLeftRadius, lty);
			
			// draw top
			for each (iTipArrow in iTipArrowArray) {
				if (iTipArrow.arrowDirection == TOP) {
					sx = x + iTipArrow.distanceA;
					sy = lty;
					ex = x + iTipArrow.distanceB;
					ey = lty;
					g.lineTo(sx, sy);
					iTipArrow.drawTip(g, sx, sy, ex, ey);
					g.lineTo(ex, ey);
				}
			}
			g.lineTo(rtx - topRightRadius, rty);
	
			// top-right corner
			a = topRightRadius * 0.292893218813453;
			s = topRightRadius * 0.585786437626905;
			
			g.curveTo(rtx - s, rty, rtx - a, rty + a);
			g.curveTo(rtx, rty + s, rtx, rty + topRightRadius);
			
			// draw right
			for each (iTipArrow in iTipArrowArray) {
				if (iTipArrow.arrowDirection == RIGHT) {
					sx = rtx;
					sy = y + iTipArrow.distanceA;
					ex = rtx;
					ey = y + iTipArrow.distanceB;
					g.lineTo(sx, sy);
					iTipArrow.drawTip(g, sx, sy, ex, ey);
					g.lineTo(ex, ey);
				}
			}			
			g.lineTo(rbx, rby - bottomRightRadius);
		}

	}
}
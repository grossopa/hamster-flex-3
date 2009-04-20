package org.hamster.utils
{
	import flash.display.Graphics;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 	
	public class GraphicsExtendUtil
	{
		public static function drawPoly(g:Graphics, points:Array):void
		{
			if (points.length == 0) return;
			g.moveTo(points[0].x, points[0].y);
			for (var i:int = 1; i < points.length; i++) {
				g.lineTo(points[i].x, points[i].y);
			}
			g.lineTo(points[0].x, points[0].y);
		}
	}
}
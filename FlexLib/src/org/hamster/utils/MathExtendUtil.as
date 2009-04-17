package org.hamster.utils
{
	import flash.geom.Point;
	
	public class MathExtendUtil
	{
		
		// p1 & p2 is the line point
		public static function isThreeSameLine(p1:Point, p2:Point, p3:Point, inaccuracy:Number = 0.01):Boolean
		{
			var l1:Number = Math.sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
			var l2:Number = Math.sqrt((p1.x - p3.x) * (p1.x - p3.x) + (p1.y - p3.y) * (p1.y - p3.y));
			var l3:Number = Math.sqrt((p2.x - p3.x) * (p2.x - p3.x) + (p2.y - p3.y) * (p2.y - p3.y));
			return Math.abs(l1 - l3 - l2) < inaccuracy;
		}
	}
}
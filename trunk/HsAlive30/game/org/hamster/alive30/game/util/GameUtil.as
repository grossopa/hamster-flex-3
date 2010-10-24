package org.hamster.alive30.game.util
{
	public class GameUtil
	{
		public static function hitTest(target1:Object, target2:Object, 
									   tar1HitWidth:Number = -1, tar1HitHeight:Number = -1,
									   tar2HitWidth:Number = -1, tar2HitHeight:Number = -1,
									   isCircle:Boolean = true):Boolean
		{
			if (tar1HitWidth == -1) {
				tar1HitWidth = target1.width;
			}
			if (tar2HitWidth == -1) {
				tar2HitWidth = target2.width;
			}
			if (tar1HitHeight == -1) {
				tar1HitHeight = target1.height;
			}
			if (tar2HitHeight == -1) {
				tar2HitHeight = target2.height;
			}
			
			if (isCircle) {
				var center1X:Number = target1.x + target1.width  * 0.5;
				var center1Y:Number = target1.y + target1.height * 0.5;
				var center2X:Number = target2.x + target2.width  * 0.5;
				var center2Y:Number = target2.y + target2.height * 0.5;
				if (Math.abs(center1X - center2X) < tar1HitWidth + tar2HitWidth
					&& Math.abs(center1Y - center2Y) < tar1HitHeight + tar2HitHeight) {
					return true;
				} else {
					return false;
				}
			} else {
				// not implemented
				return false;
			}
			
		}
	}
}
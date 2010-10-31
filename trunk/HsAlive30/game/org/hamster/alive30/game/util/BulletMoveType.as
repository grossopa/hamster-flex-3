package org.hamster.alive30.game.util
{
	import org.hamster.alive30.common.util.Vector2D;

	public class BulletMoveType
	{
		public static const STRAIGHT:String = "straight";
		public static const DEFAULT:String 	= "default";
		public static const FOLLOW:String 	= "follow";
		
		public function BulletMoveType()
		{
		}
		
		public static function straight(source:Object, accelVector:Vector2D, target:Object, speed:Number):void
		{
			accelVector.x = 0;
			accelVector.y = 0;
		}
		
		public static function follow(source:Object, accelVector:Vector2D, target:Object, speed:Number):void
		{
			accelVector.x = target.cx - source.cx;
			accelVector.y = target.cy - source.cy;
			accelVector.length = GameConstants.TURN_SPEED;
			
			if (isNaN(source.speedVector.x)) {
				source.speedVector.x = accelVector.x;
			}
			if (isNaN(source.speedVector.y)) {
				source.speedVector.y = accelVector.y;
			}
			if (source.speedVector.x == 0 && source.speedVector.y == 0) {
				source.speedVector.x = accelVector.x;
				source.speedVector.y = accelVector.y;
			}
			source.speedVector.length = GameConstants.MOVE_SPEED;
		}
	}
}
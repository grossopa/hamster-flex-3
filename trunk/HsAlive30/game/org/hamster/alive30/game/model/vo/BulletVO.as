package org.hamster.alive30.game.model.vo
{
	import org.hamster.alive30.common.util.Vector2D;

	public class BulletVO
	{
		public var cx:Number;
		public var cy:Number;
		public var type:String;
		public var moveType:String;
		public const speedVector:Vector2D = new Vector2D();
		public const accelVector:Vector2D = new Vector2D();
	}
}
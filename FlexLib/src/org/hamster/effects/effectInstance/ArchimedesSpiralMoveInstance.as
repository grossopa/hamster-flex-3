package org.hamster.effects.effectInstance
{
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 * x = cos(angle) * a * angle
	 * y = sin(angle) * a * angle
	 */
	public class ArchimedesSpiralMoveInstance extends AbstractCurveMoveInstance
	{
		public var a:Number;
		public var oX:Number;
		public var oY:Number;
		public var angleFrom:Number;
		public var angleTo:Number;
		
		public function ArchimedesSpiralMoveInstance(target:Object)
		{
			super(target);
		}
		
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
			var val:Number = Number(value);
			var curAngle:Number = this.angleFrom 
					+ val * (this.angleTo - this.angleFrom);
			
			var cos:Number = Math.cos(curAngle);
			var sin:Number = Math.sin(curAngle);
			
			var curX:Number = a * curAngle * cos + oX;
			var curY:Number = a * curAngle * sin + oY;
			
			this.target.x = curX;
			this.target.y = curY;
			
		} 
		
	}
}
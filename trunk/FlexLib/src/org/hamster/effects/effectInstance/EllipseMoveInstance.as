package org.hamster.effects.effectInstance
{
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 * (x - oX)^2   (y - oY)^2
	 * ---------- + ---------- = 1
	 *     a^2          b^2
	 * 
	 * x = oX + a * cos(angle)
	 * y = oY + b * sin(angle)
	 * 
	 * 
	 */
	public class EllipseMoveInstance extends AbstractCurveMoveInstance
	{
		public var a:Number;
		public var b:Number;
		public var oX:Number;
		public var oY:Number;
		public var angleFrom:Number;
		public var angleTo:Number;
		
		public function EllipseMoveInstance(target:Object)
		{
			super(target);
		}
		
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
			var val:Number = Number(value);
			var curAngle:Number = this.angleFrom 
					+ val * (this.angleTo - this.angleFrom);
			var curX:Number = a * Math.cos(curAngle) + oX;
			var curY:Number = b * Math.sin(curAngle) + oY;
			
			this.target.x = curX;
			this.target.y = curY;
			
		} 
		
	}
}
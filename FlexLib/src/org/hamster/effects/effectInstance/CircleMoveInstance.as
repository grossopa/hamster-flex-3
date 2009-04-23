package org.hamster.effects.effectInstance
{
	import org.hamster.errors.TodoError;
	
	public class CircleMoveInstance extends AbstractCurveMoveInstance
	{
		public var radius:Number;
		public var oX:Number;
		public var oY:Number;
		public var angleFrom:Number;
		public var angleTo:Number;		
		
		public function CircleMoveInstance(target:Object)
		{
			super(target);
		}
		
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
			var val:Number = Number(value);
			var curAngle:Number = this.angleFrom 
					+ val * (this.angleTo - this.angleFrom);
			var curX:Number = radius * Math.cos(curAngle) + oX;
			var curY:Number = radius * Math.sin(curAngle) + oY;
			
			this.target.x = curX;
			this.target.y = curY;
			
		} 
		
	}
}
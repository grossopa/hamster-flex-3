package org.hamster.effects.effectInstance
{
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 * y = a * x + b / x
	 * 
	 */
	public class NikeMoveInstance extends AbstractCurveMoveInstance
	{
		public var a:Number;
		public var b:Number;
		public var oX:Number;
		public var oY:Number;
		public var xFrom:Number;
		public var xTo:Number;		

		public function NikeMoveInstance(target:Object)
		{
			super(target);
		}
		
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
			var val:Number = Number(value);
			var curX:Number = this.xFrom 
					+ val * (this.xTo - this.xFrom);
					
			var curY:Number = a * curX + b / curX;
			
			this.target.x = curX + oX;
			this.target.y = curY + oY;
			
		} 
		
	}
}
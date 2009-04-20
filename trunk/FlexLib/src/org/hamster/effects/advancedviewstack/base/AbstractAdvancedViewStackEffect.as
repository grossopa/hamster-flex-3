package org.hamster.effects.advancedviewstack.base
{
	import org.hamster.components.AdvancedViewStack;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * This is an abstract method.  Every AVS effects should extend this class.
	 */
	public class AbstractAdvancedViewStackEffect 
			implements IAdvancedViewStackEffect
	{
		protected var _eff1:Array;
		protected var _eff2:Array;
		protected var _isQueue:Boolean;
		public var advViewStack:AdvancedViewStack;
		
		public function AbstractAdvancedViewStackEffect(arg:AdvancedViewStack)
		{
			this.advViewStack = arg;
			_eff1 = new Array();
			_eff2 = new Array();
		}
		
		public function get eff1():Array
		{
			return this._eff1;
		}
		
		public function get eff2():Array
		{
			return this._eff2;
		}
		
		public function get isQueue():Boolean
		{
			return this._isQueue;
		}
		
		public function get type():String
		{
			return "";
		}
		
		/**
		 * get direction
		 */
		public function leftDirection():Boolean
		{
			return advViewStack.direction == AdvancedViewStack.TURN_LEFT;
		}
		
		public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
		}
		
		public function initAnimation():void
		{
		}

	}
}
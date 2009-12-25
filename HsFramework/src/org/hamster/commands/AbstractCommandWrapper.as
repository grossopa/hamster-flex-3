package org.hamster.commands
{
	public class AbstractCommandWrapper extends AbstractCommand implements ICommandWrapper
	{
		private var _cmdArray:Array;
		protected var nextIndex:int;
		
		public function get cmdArray():Array
		{
			return _cmdArray;
		}
		
		public function set cmdArray(value:Array):void
		{
			this._cmdArray = value;
		}
		
		public function get curCmd():ICommand
		{
			return nextIndex == 0 ? null : ICommand(_cmdArray[nextIndex - 1]);
		}
		
		public function get curIndex():int
		{
			return this.nextIndex - 1;
		}
		
		
		
		public function AbstractCommandWrapper()
		{
			super();
		}
		
	}
}
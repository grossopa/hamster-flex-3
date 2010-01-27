package org.hamster.commands
{
	/**
	 * Abstract command wrapper. You extend this class for further usage of
	 * handling multiple commands.
	 */
	public class AbstractCommandWrapper extends AbstractCommand implements ICommandWrapper
	{
		/**
		 * Command array.
		 */
		private var _cmdArray:Array;
		
		/**
		 * Record cur index while excute
		 */
		protected var _curIndex:int = -1;
		
		/**
		 * Getter function return command array.
		 */
		public function get cmdArray():Array
		{
			return _cmdArray;
		}
		
		/**
		 * Setter function to set command array value.
		 */
		public function set cmdArray(value:Array):void
		{
			this._cmdArray = value;
		}
		
		/**
		 * return current executing command, if none is executing,
		 * return null.
		 */
		public function get curCmd():ICommand
		{
			return _curIndex < 0 ? null : ICommand(_cmdArray[_curIndex]);
		}
		
		/**
		 * return cur executing command index.
		 */
		public function get curIndex():int
		{
			return this._curIndex;
		}
		
		/**
		 * @private
		 * 
		 * Constructor
		 */
		public function AbstractCommandWrapper()
		{
			super();
		}
		
	}
}
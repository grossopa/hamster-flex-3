package org.hamster.errors
{
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 * for development
	 */
	public class TodoError extends Error
	{
		public static const NOT_IMPLEMENTED:String = "Not implemented.";
		
		public function TodoError(message:String=NOT_IMPLEMENTED, id:int=0)
		{
			super(message, id);
		}
		
	}
}
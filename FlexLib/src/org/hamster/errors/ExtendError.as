package org.hamster.errors
{
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 */
	public class ExtendError extends Error
	{
		public static const ABSTRACT:String = "Call an abstract function.";
		
		public function ExtendError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
	}
}
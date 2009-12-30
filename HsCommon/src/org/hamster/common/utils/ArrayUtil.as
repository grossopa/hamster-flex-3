package org.hamster.common.utils
{
	/**
	 * This is a utility class so you needn't create instance.
	 * 
	 */
	public class ArrayUtil
	{
		public function ArrayUtil()
		{
		}
		
		public static function swap(array:Object, index1:int, index2:int):void
		{
			var temp:Object = array[index1];
			array[index1] = array[index2];
			array[index2] = temp;
		} 

	}
}
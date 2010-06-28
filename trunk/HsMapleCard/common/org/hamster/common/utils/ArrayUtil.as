package org.hamster.common.utils
{
	import mx.collections.ArrayCollection;
	
	/**
	 * 
	 * @author yinz
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
		
		public static function shallowCopyArray(array:Array):Array
		{
			var result:Array = new Array();
			for each (var obj:Object in array) {
				result.push(obj);
			}
			return result;
		}

	}
}
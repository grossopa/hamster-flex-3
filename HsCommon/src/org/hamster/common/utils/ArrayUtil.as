package org.hamster.common.utils
{
	import mx.collections.ArrayCollection;
	
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
		
		public static function shallowCopyArray(array:Array):Array
		{
			if (array == null) {
				return null;
			}
			var result:Array = new Array();
			for each (var object:Object in array) {
				result.push(object);
			}
			return result;
		}
		
		public static function shallowCopyArrayCollection(array:ArrayCollection):ArrayCollection
		{
			if (array == null) {
				return null;
			}
			var result:ArrayCollection = new ArrayCollection();
			for each (var object:Object in array) {
				result.addItem(object);
			}
			return result;
		}

	}
}
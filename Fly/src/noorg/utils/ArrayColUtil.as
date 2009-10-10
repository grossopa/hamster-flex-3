package noorg.utils
{
	import mx.collections.ArrayCollection;
	
	public class ArrayColUtil
	{
		public static function connect(father:Object, next:Object):void
		{
			for each (var child:Object in next) {
				if (father is Array) {
					father.push(child);
				} else if (father is ArrayCollection) {
					father.addItem(child);
				}
			}
		}
		
		/**
		 * @param father either an Array or an ArrayCollection
		 * @param item, the target to remove
		 * @return removed item
		 */
		public static function removeItem(father:Object, item:Object):Object
		{
			if (father is Array) {
				var arr:Array = father as Array;
				var index:int = arr.indexOf(item);
				arr.splice(index, 1);
			} else if (father is ArrayCollection) {
				var arrCol:ArrayCollection = ArrayCollection(father);
				arrCol.removeItemAt(arrCol.getItemIndex(item));
			}
			return item;
		}
		
		/**
		 * 
		 */
		public static function hasValue(value:Object, arr:Object):Boolean
		{
			if (value == null) {
				return false;
			}
			
			var s:Object;
			
			if (arr is Array) {
				var array:Array = arr as Array;
				for each (s in array) {
					if (s != null && s.toString() == value.toString()) {
						return true;
					}
				}
			}
			
			if (arr is ArrayCollection) {
				var arrCol:ArrayCollection = ArrayCollection(arr);
				for each (s in arrCol) {
					if (s != null && s.toString() == value.toString()) {
						return true;
					}
				}
			}

			return false;
		}
	}
}
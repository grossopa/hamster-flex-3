package org.hamster.magic.common.utils
{
	public class XMLStringUtil
	{
		public function XMLStringUtil()
		{
		}
		
		public static function encodeArray2String(array:Array):String 
		{
			if (array == null || array.length == 0) {
				return "";
			}
			var result:String = "";
			for (var i:int = 0; i < array.length - 1; i++) {
				result += array[i].toString() + ",";
			}
			result += array[array.length - 1];
			return result;
		}
		
		public static function string2int(s:String):Array
		{
			var arr:Array = s.split(',');
			var result:Array = new Array();
			
			for each (var temp:String in arr) {
				result.push(parseInt(temp));
			}
			return result;
		}

	}
}
package org.hamster.enterprise.utils
{
	import mx.utils.StringUtil;

	public class HsStringUtil
	{
		public static function insertCharacter(
			original:String, char:String, index:int):String
		{
			if (char == null || char == "") {
				return original;
			}
			if (index <= 0) {
				return char + original;
			} else if (index >= original.length) {
				return original + char;
			} else {
				return original.substring(0, index) 
					+ char + original.substring(index);
			}
		}
		
		public static function removeCharacter(
			original:String, char:String):String
		{
			if (isEmpty(original) || char == null || char == "") {
				return original;
			}
			
			var result:String = original;
			while (result.indexOf(char) >= 0) {
				var index:int = result.indexOf(char);
				trace(index);
				if (index == 0) {
					result = result.substring(char.length);
				} else if (index == length - 1) {
					result = result.substring(0, result.length - char.length);
				} else {
					result = result.substring(0, index) 
						+ result.substring(index + char.length);
				}
			}
			
			return result;
		}
		
		public static function isEmpty(str:String):Boolean
		{
			return str == null || str == "" || StringUtil.trim(str) == "";
		}
										  
	}
}
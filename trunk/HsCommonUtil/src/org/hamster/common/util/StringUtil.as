package org.hamster.common.util
{
	import mx.utils.StringUtil;

	public class StringUtil
	{
		public static function isEmpty(str:String):Boolean
		{
			return !str || str == "" || mx.utils.StringUtil.trim(str) == "";
		}
		
		/**
		 * compare two strings
		 *  
		 * @param str1
		 * @param str2
		 * @param nullable
		 * @return 
		 * 
		 */
		public static function compare(str1:String, str2:String, nullable:Boolean = false):Boolean
		{
			if (!nullable) {
				return isEmpty(str1) && isEmpty(str2) && str1 == str2;
			} else {
				return str1 == str2;
			}
		}
	}
}
package org.hamster.common.util
{
	import mx.utils.StringUtil;

	public class StringUtil
	{
		public static function isEmpty(str:String):Boolean
		{
			return !str || str == "" || mx.utils.StringUtil.trim(str) == "";
		}
	}
}
package noorg.utils
{
	public class DebugUtil
	{
		public static function assertTrue(value:Boolean):void
		{
			if (!value) {
				throw new Error("assertion failed.");
			}
		}
		
		public static function assertFalse(value:Boolean):void
		{
			if (value) {
				throw new Error("assertion failed.");
			}
		}

	}
}
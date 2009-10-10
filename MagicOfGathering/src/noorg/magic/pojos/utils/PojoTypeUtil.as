package noorg.magic.pojos.utils
{
	public class PojoTypeUtil
	{
		public static function getDatabaseType(obj:Object):String
		{
			if (obj is String) {
				return PojoType.TEXT;
			} else if (obj is Boolean) {
				return PojoType.BOOLEAN;
			} else if (obj is int) {
				return PojoType.INTEGER;
			}
			return "";
			
		}

	}
}
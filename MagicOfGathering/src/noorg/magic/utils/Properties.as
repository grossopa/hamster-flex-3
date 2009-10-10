package noorg.magic.utils
{
	public class Properties
	{
		public static var databasePath:String;
		public static var databasePassword:String;
		[Bindable]
		public static var locales:Array;
		
		public static function get defaultLocale():String
		{
			if (locales != null && locales.length > 0) {
				return locales[0] as String;
			}
			return null;
		}

	}
}
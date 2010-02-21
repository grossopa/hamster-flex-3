package org.hamster.magic.common.utils
{
	import mx.collections.ArrayCollection;
	
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
		
		[Bindable]
		public static var cardNum:int;
		
		[Bindable]
		public static var knownCardCollections:Array = new Array();

	}
}
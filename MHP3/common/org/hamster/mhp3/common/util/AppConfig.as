package org.hamster.mhp3.common.util
{
	public class AppConfig
	{
		public static const TEST_MODE:Boolean = true;
		
		public static var rootURL:String;
		public static var weaponImageRootURL:String;
		
		public static function get WEAPON_XML():String {
			if (TEST_MODE) {
				return "org/hamster/mhp3/assets/main.xml";
			} else {
				return rootURL + "case_list.xml";
			}
		}
		
	}
}
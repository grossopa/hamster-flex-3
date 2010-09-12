package org.hamster.showcase.common.config
{
	public class AppConfig
	{
		public static const TEST_MODE:Boolean = true;
		
		public static var rootURL:String;
		
		public static function get URL_CASE_LIST():String {
			if (TEST_MODE) {
				return "test/xml/case_list.xml";
			} else {
				return rootURL + "case_list.xml";
			}
		}
	}
}
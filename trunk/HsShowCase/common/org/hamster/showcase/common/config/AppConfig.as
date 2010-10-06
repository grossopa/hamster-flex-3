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
		
		public static function get URL_CROP_IMAGE_LIST():String {
			if (TEST_MODE) {
				return "test/xml/crop_image_list.xml";
			} else {
				return rootURL + "crop_image_list.xml";
			}
		}
		
		public static function get URL_IMAGE_RULER():String {
			if (TEST_MODE) {
				return "test/xml/image_ruler.xml";
			} else {
				return rootURL + "image_ruler.xml";
			}
		}
	}
}
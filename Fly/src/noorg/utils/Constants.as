package noorg.utils
{
	import flash.filesystem.File;
	
	public class Constants
	{
		public static function get ROOT_PATH():String
		{
			return File.applicationDirectory.nativePath;
		}
		
		public static function get PAGE_FILE_FOLDER():String
		{
			return ROOT_PATH + File.separator + "resources" 
					+ File.separator + "page";
		}
		
		public static function get BACKROUND_IMAGE_FILE_FOLDER():String {
			 return ROOT_PATH + File.separator + "resources" 
					+ File.separator + "backgroundImage";
		}
		
		public static const SUPPORTED_IMAGE_TYPE:Array = [".jpg", ".bmp", ".png"];		
	}
}
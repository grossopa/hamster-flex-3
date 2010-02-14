package org.hamster.gamesaver.utils
{
	import flash.filesystem.File;
	
	public class FileUtil
	{
		/**
		 * an array contains illegal characters which cannot be used in file name or file path.
		 */
		public static const ILLEGAL_CHARACTERS:Array = [':','*','/','|','\\','?','"','<','>'];
		
		/**
		 * Check is file name legal.
		 * 
		 * @param name
		 * @return is legal
		 */
		public static function isFileNameLegal(name:String):Boolean
		{
			for each (var char:String in ILLEGAL_CHARACTERS) {
				if (name.indexOf(char) != -1) {
					return false;
				}
			} 
			return true;
		}		
		
		public static function checkPath(path:String):Boolean
		{
			try {
				var file:File = new File(path);
			} catch (e:Error) {
				return false;
			}
			return file.exists;
		}
		
		public static function getConfFile():File
		{
			return new File(File.applicationDirectory.nativePath + File.separator + "conf.xml");
		}

	}
}
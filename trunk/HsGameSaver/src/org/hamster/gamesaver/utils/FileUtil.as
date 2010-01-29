package org.hamster.gamesaver.utils
{
	import flash.filesystem.File;
	
	public class FileUtil
	{
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
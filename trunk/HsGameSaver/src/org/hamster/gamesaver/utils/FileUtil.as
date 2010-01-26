package org.hamster.gamesaver.utils
{
	import flash.filesystem.File;
	
	public class FileUtil
	{
		public static function checkPath(path:String):Boolean
		{
			var file:File = new File(path);
			return file.exists;
		}
		
		public static function getConfFile():File
		{
			return new File(File.applicationDirectory.nativePath + File.separator + "conf.xml");
		}

	}
}
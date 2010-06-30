package org.hamster.mapleCard.base.utils
{
	import flash.filesystem.File;

	public class FileUtil
	{
		private static var _rootDir:File;
		private static var _creatureDir:File;
		
		public static function get rootDir():File
		{
			if (_rootDir == null) {
				_rootDir = File.applicationDirectory;
			}
			return _rootDir;
		}
		
		public static function get creatureDir():File
		{
			if (_creatureDir == null) {
				_creatureDir = new File(rootDir.nativePath 
					+ File.separator + "Creatures");
			}
			return _creatureDir;
		}
	}
}
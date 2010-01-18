package noorg.magic.utils
{
	import flash.filesystem.File;
	
	public class FileUtil
	{
		/**
		 * an array contains illegal characters which cannot be used in file name or file path.
		 */
		public static const ILLEGAL_CHARACTERS:Array = [':','*','/','|','\\','?','"','<','>'];
		
		/**
		 * check is file name legal.
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
		
		public static function getCardFolder():File
		{
			var result:File = new File(File.applicationDirectory.nativePath + File.separator + "card");
			if (!result.exists) {
				result.createDirectory();
			}
			return result;
		}
		
		public static function getUserSaveFolder():File
		{
			var result:File = new File(File.applicationDirectory.nativePath + File.separator + "save");
			if (!result.exists) {
				result.createDirectory();
			}
			return result;
		}
		
		public static function getCardFolderByCollection(name:String):File
		{
			if (name == null || name.length == 0) {
				return null;
			}
			var result:File = new File(getCardFolder().nativePath + File.separator + name);
			if (!result.exists) {
				result.createDirectory();
			}
			return result;
		}
		
		public static function getUserSaveFolderByCollection(name:String):File
		{
			if (name == null || name.length == 0) {
				return null;
			}
			var result:File = new File(getUserSaveFolder().nativePath + File.separator + name);
			if (!result.exists) {
				result.createDirectory();
			}
			return result;
		}
		
		public static function getUserSaveMetaFileByCollection(name:String):File
		{
			var result:File = new File(getUserSaveFolderByCollection(name).nativePath + File.separator + "meta.xml");
			return result;
		}
		
		public static function getCardInfoByPid(collection:String, pid:int):File
		{
			var result:File = new File(getCardFolderByCollection(collection).nativePath
			      + File.separator + pid.toString() + ".xml");
			return result;
		}
	}
}
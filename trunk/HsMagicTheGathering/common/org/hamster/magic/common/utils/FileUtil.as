package org.hamster.magic.common.utils
{
	import flash.filesystem.File;
	
	/**
	 * Contains file access functions.
	 */
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
		
		/**
		 * The folder contains all base card information. Format: "/{app}/card".
		 * 
		 * 
		 * @return cardFolder
		 */
		public static function getCardFolder():File
		{
			var result:File = new File(File.applicationDirectory.nativePath + File.separator + "card");
			if (!result.exists) {
				result.createDirectory();
			}
			return result;
		}
		
		/**
		 * The folder contains all user saved information (like saved collection). Format: "/{app}/save".
		 * 
		 * @return userSaveFolder 
		 */
		public static function getUserSaveFolder():File
		{
			var result:File = new File(File.applicationDirectory.nativePath + File.separator + "save");
			if (!result.exists) {
				result.createDirectory();
			}
			return result;
		}
		
		/**
		 * The folder contains a base collection information. Format: "/{app}/card/{name}".
		 * 
		 * @param name collectionName
		 * @return collectionFolder
		 */
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
		
		/**
		 * The folder contains a user saved collection information. Format: "/{app}/save/{name}".
		 * 
		 * @param name saved collection name
		 * @return saved collection folder
		 */
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
		
		/**
		 * Return the meta file of user saved collection. Format: "/{app}/save/{name}/meta.xml".
		 * 
		 * @param saved collection name
		 * @return meta.xml
		 */
		public static function getUserSaveMetaFileByCollection(name:String):File
		{
			var result:File = new File(getUserSaveFolderByCollection(name).nativePath + File.separator + "meta.xml");
			return result;
		}
		
		/**
		 * return base card xml by collection and pid. Format: "/{app}/card/{pid}.xml".
		 * 
		 * @param collection collection name
		 * @param pid card pid
		 * @return {pid}.xml
		 */
		public static function getCardInfoByPid(collection:String, pid:int):File
		{
			var result:File = new File(getCardFolderByCollection(collection).nativePath
			      + File.separator + pid.toString() + ".xml");
			return result;
		}
	}
}
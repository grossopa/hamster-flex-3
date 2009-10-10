package noorg.magic.utils
{
	import flash.filesystem.File;
	
	public class Configures
	{
		public static function getCardFolder():File
		{
			var result:File = new File(File.applicationDirectory.nativePath + File.separator + "card");
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
	}
}
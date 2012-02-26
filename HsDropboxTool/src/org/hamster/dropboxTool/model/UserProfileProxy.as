package org.hamster.dropboxTool.model
{
	import flash.filesystem.File;
	
	import org.hamster.dropbox.DropboxConfig;
	import org.hamster.framework.puremvc.HsProxy;
	
	public class UserProfileProxy extends HsProxy
	{
		public static const NAME:String = "UserProfileProxy";
		
		public static const USERS_FOLDER:String = "users";
		public static const USER_FILE:String = "user.properties";
		
		public function UserProfileProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function createProfile(config:DropboxConfig):void
		{
			var folderName:String = config.accessTokenKey;
			var userRootFolder:File = new File(File.applicationStorageDirectory + File.separator + USERS_FOLDER);
			if (!userRootFolder.exists) {
				userRootFolder.createDirectory();
			}
			
			var userFolder:File = new File(userRootFolder.nativePath + File.separator + folderName);
			if (!userFolder.exists) {
				userFolder.createDirectory();
			}
			
			var profileFile:File = new File(userFolder.nativePath + File.separator + USER_FILE);
			
		}
		
		public function saveProfile(config:DropboxConfig):void
		{
			
		}
		
		public function deleteProfile(accessTokenKey:String):void
		{
			
		}
	}
}
package noorg.magic.commands.impl.init
{
	import com.adobe.data.encryption.EncryptionKeyGenerator;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	import noorg.magic.utils.Properties;
	
	import org.hamster.commands.AbstractCommand;

	public class InitializeDatabaseCmd extends AbstractCommand
	{
		private var _encryptionKey:ByteArray;
		private var dbFile:File;
		public var conn:SQLConnection;
		
		public function getEncryptionKey():ByteArray
		{
			if (_encryptionKey == null) {
			_encryptionKey = new EncryptionKeyGenerator()
					.getEncryptionKey(dbFile, Properties.databasePassword);
			}
			return _encryptionKey;
		}
		
		public function InitializeDatabaseCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			dbFile = new File(Properties.databasePath);
			conn = new SQLConnection();
			if (!dbFile.exists) {
				new FileStream().open(dbFile, FileMode.WRITE);
				conn.openAsync(dbFile, SQLMode.CREATE, this.flashNetResponder, false, 1024, null);
			} else {
				conn.openAsync(dbFile, SQLMode.UPDATE, this.flashNetResponder, false, 1024, null);
			}
		}
		
		override public function result(data:Object):void
		{
			// Alert.show("create database success");
			super.result(data);
		}
		
		override public function fault(info:Object):void
		{
			Alert.show("Create database failed");
			super.fault(info);	
		}
		
	}
}
package org.hamster.gamesaver.commands
{
	import deng.fzip.FZip;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.formatters.DateFormatter;
	
	import org.aszip.saving.Method;
	import org.hamster.commands.AbstractCommand;
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.commands.impl.CommandQueue;
	import org.hamster.gamesaver.models.Game;

	public class GenerateZipCmd extends AbstractCommand
	{
		private var _fs:FileStream;
		
		public var games:Array;
		
		public var targetZipFolder:File;
		
		public function GenerateZipCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var cmdArray:Array = new Array();
			var queue:CommandQueue = new CommandQueue(cmdArray);
			for each (var game:Game in games) {
				var targetFolder:File = new File(File.applicationDirectory.nativePath
						+ File.separator + "temp" + File.separator + game.name);
				var saveFolder:File = new File(game.savePath);
				var files:Array = saveFolder.getDirectoryListing();
				for each (var file:File in files) {
					var copyCmd:CopyFileAndReadCmd = new CopyFileAndReadCmd();
					copyCmd.file = file;
					copyCmd.targetFolder = targetFolder;
					cmdArray.push(copyCmd);
				}
			} 
			queue.addEventListener(CommandEvent.COMMAND_RESULT, queueCompleteHandler);
			queue.execute();
		}
		
		private function queueCompleteHandler(evt:CommandEvent):void
		{
			var queue:CommandQueue = CommandQueue(evt.currentTarget);
			//var asZip:ASZip = new ASZip(CompressionMethod.GZIP);
			var fZip:FZip = new FZip();
			for each (var game:Game in games) {
			//	asZip.addDirectory(game.name);
			}

			for each (var copyCmd:CopyFileAndReadCmd in queue.cmdArray) {
				var file:File = copyCmd.copiedFile;
				if (file.data != null) {
					fZip.addFile(file.name, file.data);  
					//asZip.addFile(file.data,  file.name);
				}
			}
			//var zipFileByteArray:ByteArray = asZip.saveZIP(Method.LOCAL);
			var zipFileByteArray:ByteArray = new ByteArray();
			fZip.serialize(zipFileByteArray);
			var df:DateFormatter = new DateFormatter();
			df.formatString = "YYYYMMDD_J,NN,SS";
			if (targetZipFolder == null) {
				targetZipFolder = new File(File.applicationDirectory.nativePath);
			} else if (!targetZipFolder.isDirectory) {
				targetZipFolder = new File(targetZipFolder.parent.nativePath);
			}
			
			var targetZipFile:File = new File(targetZipFolder.nativePath + File.separator + "save_"
					+ df.format(new Date()) + ".zip");
			_fs = new FileStream();
			_fs.openAsync(targetZipFile, FileMode.WRITE);
			_fs.writeBytes(zipFileByteArray, 0, zipFileByteArray.length);
			_fs.close();
			this.result(null);
		}
		
		public static function urlencodeGB2312(str:String):String{
			var result:String ="";
   			var byte:ByteArray =new ByteArray();
			byte.writeMultiByte(str, "GBK");
			for(var i:int;i<byte.length;i++){
				result += String.fromCharCode(byte[i]);
			}
			//result = byte.readUTFBytes(byte.bytesAvailable);
   			return result;
  		}		
	}
	

}
package org.hamster.gamesaver.commands
{
	import deng.fzip.FZip;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.formatters.DateFormatter;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.commands.impl.CommandQueue;
	import org.hamster.gamesaver.models.Game;

	public class GenerateZipCmd extends AbstractCommand
	{
		public static const TMP_FOLDER:File = new File(File.applicationDirectory.nativePath + File.separator + "temp");
		
		private var _fs:FileStream;
		
		public var games:Array;
		
		public var targetZipFolder:File;
		
		private var _targetZipFile:File;
		
		public function get targetZipFile():File {
			return this._targetZipFile;
		}
		
		public function GenerateZipCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var cmdArray:Array = new Array();
			var queue:CommandQueue = new CommandQueue(cmdArray);
			for each (var game:Game in games) {
				var saveFolder:File = new File(game.savePath);
				var files:Array = saveFolder.getDirectoryListing();
				
				this.parseFolder(game, saveFolder, 
						TMP_FOLDER.nativePath + File.separator + game.name 
						+ File.separator + saveFolder.name, cmdArray);
			}
			queue.addEventListener(CommandEvent.COMMAND_RESULT, queueCompleteHandler);
			queue.execute();
		}
		
		private function parseFolder(game:Game, folder:File, targetFolderString:String, cmdArray:Array):void
		{
			var files:Array = folder.getDirectoryListing();
			
			var targetFolder:File = new File(targetFolderString);
			
			for each (var file:File in files) {
				if (file.isDirectory) {
					parseFolder(game, file, targetFolderString + File.separator + file.name, cmdArray);
				} else {
					var jump:Boolean = false;
					if (game.excludes != null) {
						for each (var exStr:String in game.excludes) {
							if (file.name.toLowerCase().indexOf(exStr.toLowerCase(), file.name.length - exStr.length) >= 0) {
								jump = true;
								break;
							}
						}
					}
					if (game.includes != null) {
						for each (var inStr:String in game.includes) {
							if (file.name.toLowerCase().indexOf(inStr.toLowerCase(), file.name.length - inStr.length) < 0) {
								jump = true;
								break;
							}
						}
					}
					
					if (jump) {
						continue;
					}
					var copyCmd:CopyFileAndReadCmd = new CopyFileAndReadCmd();
					copyCmd.file = file;
					copyCmd.targetFolder = targetFolder;
					cmdArray.push(copyCmd);					
				}
			}
		}
		
		private function queueCompleteHandler(evt:CommandEvent):void
		{
			var queue:CommandQueue = CommandQueue(evt.currentTarget);
			//var asZip:ASZip = new ASZip(CompressionMethod.GZIP);
			var fZip:FZip = new FZip();
			
//			for (var i:int = 0; i < games.length; i++) {
//				var game:Game = Game(games[i]);
//				var copyCmd:CopyFileAndReadCmd = CopyFileAndReadCmd(queue.cmdArray[i]);
//				if (copyCmd.copiedFile.data != null) {
//					fZip.addFile(game.name + "/" + copyCmd.copiedFile.name, 
//							copyCmd.copiedFile.data);  
//				}
//			}

			for each (var copyCmd:CopyFileAndReadCmd in queue.cmdArray) {
				var file:File = copyCmd.copiedFile;
				if (file.data != null) {
					fZip.addFile(copyCmd.targetFolder.nativePath
							.replace(TMP_FOLDER.nativePath + File.separator, "")
							.replace("\\","/") + "/" + file.name, file.data);  
					//asZip.addFile(file.data,  file.name);
				}
			}
			//var zipFileByteArray:ByteArray = asZip.saveZIP(Method.LOCAL);
			var zipFileByteArray:ByteArray = new ByteArray();
			fZip.serialize(zipFileByteArray);
			var df:DateFormatter = new DateFormatter();
			df.formatString = "YYYYMMDD_JNNSS";
			if (targetZipFolder == null) {
				targetZipFolder = new File(File.applicationDirectory.nativePath);
			} else if (!targetZipFolder.isDirectory) {
				targetZipFolder = new File(targetZipFolder.parent.nativePath);
			}
			
			_targetZipFile = new File(targetZipFolder.nativePath + File.separator + "save_"
					+ df.format(new Date()) + ".zip");
			_fs = new FileStream();
			_fs.openAsync(_targetZipFile, FileMode.WRITE);
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
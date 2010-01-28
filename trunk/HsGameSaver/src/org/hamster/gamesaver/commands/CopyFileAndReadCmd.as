package org.hamster.gamesaver.commands
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.hamster.commands.AbstractCommand;

	public class CopyFileAndReadCmd extends AbstractCommand
	{
		private var _file:File;
		private var _targetFolder:File;
		private var _copiedFile:File;
		
		public function set file(value:File):void
		{
			this._file = value;
		}
		
		public function set targetFolder(value:File):void
		{
			this._targetFolder = value;
		}
		
		public function get targetFolder():File
		{
			return this._targetFolder;
		}
		
		public function get copiedFile():File
		{
			return this._copiedFile;
		}
		
		public function CopyFileAndReadCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			if (!_targetFolder.exists) {
				_targetFolder.createDirectory();
			} else if (_targetFolder.exists && !_targetFolder.isDirectory) {
				this.fault(null);
			}
			_file.addEventListener(Event.COMPLETE, copyCompleteHandler);
			_copiedFile = new File(_targetFolder.nativePath + File.separator + _file.name);
			_file.copyToAsync(_copiedFile, true);
		}
		
		private function copyCompleteHandler(evt:Event):void
		{
			_file.removeEventListener(Event.COMPLETE, copyCompleteHandler);
			_copiedFile.addEventListener(Event.COMPLETE, openCompleteHandler);
			_copiedFile.load();
		}
		
		private function openCompleteHandler(evt:Event):void
		{
			this.result(null);
		}
		
	}
}
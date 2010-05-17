package org.hamster.dropbox.commands
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	import org.hamster.commands.AbstractCommand;
	import org.iotashan.utils.URLEncoding;
	
	import ru.inspirit.net.MultipartURLLoader;
	
	public class DropboxUploadCommand extends AbstractCommand
	{
		public static const UPLOAD_FILE_FIELD:String = 'file';
		
		private var _urlRequest:URLRequest;
		private var _uploadData:ByteArray;
		private var _fileName:String;
		
		private var _m:MultipartURLLoader;
		
		public function DropboxUploadCommand(urlRequest:URLRequest, data:ByteArray, fileName:String)
		{
			super();
			this._urlRequest = urlRequest;
			this._uploadData = data;
			this._fileName = fileName;
		}
		
		override public function execute():void
		{
//			this._fileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, result);
//			this._fileReference.addEventListener(IOErrorEvent.IO_ERROR, fault);
//			this._fileReference.upload(this._urlRequest, UPLOAD_FILE_FIELD);
			_m = new MultipartURLLoader();
			//_m.addVariable('file', _fileName);
			_m.requestHeaders = this._urlRequest.requestHeaders;
			_m.addFile(_uploadData, _fileName, 'file');
			_m.addEventListener(Event.COMPLETE, result);
			_m.addEventListener(IOErrorEvent.IO_ERROR, fault);
			_m.load(_urlRequest.url);
		}
		
		override public function result(data:Object):void
		{
			_m.removeEventListener(Event.COMPLETE, result);
			_m.removeEventListener(IOErrorEvent.IO_ERROR, fault);
			//this._fileReference.removeEventListener(Event.COMPLETE, result);
			//this._fileReference.removeEventListener(IOErrorEvent.IO_ERROR, fault);
			
			super.result(data);
		}
		
		override public function fault(info:Object):void
		{
			_m.removeEventListener(Event.COMPLETE, result);
			_m.removeEventListener(IOErrorEvent.IO_ERROR, fault);
			//this._fileReference.removeEventListener(Event.COMPLETE, result);
			//this._fileReference.removeEventListener(IOErrorEvent.IO_ERROR, fault);
			
			super.fault(info);
		}
		
		
	}
}
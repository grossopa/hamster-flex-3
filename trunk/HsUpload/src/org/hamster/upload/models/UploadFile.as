package org.hamster.upload.models
{
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	
	import org.hamster.upload.events.HsUploadEvent;
	
	public class UploadFile extends EventDispatcher implements IUploadFile
	{
		/**
		 * default file reference
		 */
		private var _file:FileReference;
		private var _status:int;
		private var _url:String;
		/**
		 * This value will be set to true when
		 * user clicked delete while the status is UPLOADED but not FINISEHED,
		 * then we will waiting until the processing is finished.
		 * 
		 * after that, send a delete event.
		 * 
		 */
		private var _isDeleted:Boolean;
		
		/**
		 * file name
		 */
		public var name:String;
		/**
		 * urls for download image
		 */
		public var url:String;
		
		public function set file(value:FileReference):void
		{
			if (_file != null) {
				_file.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				_file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadFinishedHandler);
				_file.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				_file.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			
			this._file = value;
			this.name = _file.name;
			
			_file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadFinishedHandler);
			_file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		public function get file():FileReference
		{
			return this._file;
		}
		
		public function set status(value:int):void
		{
			this._status = value;
		}
		
		public function get status():int
		{
			return this._status;
		}
		
		public function set isDeleted(value:Boolean):void
		{
			this._isDeleted = value;
		}
		
		public function get isDeleted():Boolean
		{
			return this._isDeleted;
		}
		
		public function UploadFile()
		{
			status = UploadFileStatus.NOT_START;
		}
		
		public function deleteFile():void
		{
			trace("[delete] " + file.name);
			this.isDeleted = this.status == UploadFileStatus.UPLOADED;
			
			var disEvt:HsUploadEvent = new HsUploadEvent(HsUploadEvent.FILE_DELETE);
			disEvt.uploadFile = this;
			this.dispatchEvent(disEvt);
		}
		
		private function securityErrorHandler(evt:SecurityErrorEvent):void
		{
			trace("[securityError] " + file.name);
			this.status = UploadFileStatus.FAILED;
			var disEvt:HsUploadEvent = new HsUploadEvent(HsUploadEvent.FILE_ERROR);
			disEvt.uploadFile = this;
			disEvt.evt = evt;
			this.dispatchEvent(disEvt);
		}
		
		private function ioErrorHandler(evt:IOErrorEvent):void
		{
			trace("[ioErrorHandler] " + file.name);
			this.status = UploadFileStatus.FAILED;
			var disEvt:HsUploadEvent = new HsUploadEvent(HsUploadEvent.FILE_ERROR);
			disEvt.uploadFile = this;
			disEvt.evt = evt;
			this.dispatchEvent(disEvt);			
		}
		
		private function uploadFinishedHandler(evt:DataEvent):void
		{
			trace("[uploadFinishedHandler] " + file.name);
			this.status = UploadFileStatus.FINISHED;
			var disEvt:HsUploadEvent = new HsUploadEvent(HsUploadEvent.FILE_FINISHED);
			disEvt.uploadFile = this;
			disEvt.evt = evt;
			this.dispatchEvent(disEvt);
		}
		
		private function progressHandler(evt:ProgressEvent):void
		{
			var disEvt:HsUploadEvent;
			if (evt.bytesLoaded != evt.bytesTotal) {
				this.status = UploadFileStatus.PROGRESS;
				disEvt = new HsUploadEvent(HsUploadEvent.FILE_PROGRESS);
				disEvt.uploadFile = this;
				disEvt.evt = evt;
				this.dispatchEvent(disEvt);
			} else {
				trace("[progressHandler] " + file.name);
				this.status = UploadFileStatus.UPLOADED;
				disEvt = new HsUploadEvent(HsUploadEvent.FILE_UPLOADED);
				disEvt.uploadFile = this;
				disEvt.evt = evt;
				this.dispatchEvent(disEvt);				
			}
		}
		
		
	}
}
package org.hamster.upload
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	
	import mx.collections.ArrayCollection;
	
	import org.hamster.upload.events.HsUploadEvent;
	import org.hamster.upload.models.IUploadFile;
	import org.hamster.upload.models.UploadFileStatus;
	import org.hamster.upload.models.UploadTaskStatus;
	
	[Event(name="fileStart", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileProgress", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileUploaded", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileFinished", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileDelete", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="fileError", type="org.hamster.upload.events.HsUploadEvent")]
	
	[Event(name="taskAdd", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="taskStart", type="org.hamster.upload.events.HsUploadEvent")]
	[Event(name="taskFinished", type="org.hamster.upload.events.HsUploadEvent")]

	public class HsUpload extends EventDispatcher
	{
		/**
		 * if you need do add some more attributes to UploadFile instance,
		 * you can extend the UploadFile or implement the IUploadFile class,
		 * then pass the class definition to setter of _uploadFileClass.
		 * 
		 * default value is UploadFile
		 * @see function get uploadFileClass():Class
		 */
		private var _uploadFileClass:Class;
		
		/**
		 * upload url
		 */
		public var url:String;
		public var sizeLimitation:int;
		public var isStartAfterSelected:Boolean = true;
		public var isAutoControl:Boolean = true;
		
		public var fileFliters:Array = new Array();
		[Bindable]
		public var files:ArrayCollection = new ArrayCollection();
		
		private var fileRef:FileReferenceList = new FileReferenceList();
		
		public function HsUpload()
		{
			super(null);
			
			fileRef.addEventListener(Event.SELECT, selectedFilesHandler);
			this.addEventListener(HsUploadEvent.TASK_ADD, taskAddHandler);
			this.addEventListener(HsUploadEvent.TASK_START, taskStartHandler);
//			this.addEventListener(HsUploadEvent.FILE_START, fileStartHandler);
		}

		public function set uploadFileClass(value:Class):void
		{
			if (_uploadFileClass is IUploadFile) {
				_uploadFileClass = value;
			} else {
				throw new Error("uploadFileClass is not IUploadFile!!!");
			}
			
		}
		
		public function get uploadFileClass():Class
		{
			if (_uploadFileClass == null) {
				_uploadFileClass = org.hamster.upload.models.UploadFile;
			}
			return _uploadFileClass;
		}
		
		// status control
		private var _status:int;
		
		public function get status():int
		{
			return _status;
		}
		
		//////////////////////
		// public functions //
		//////////////////////
		public function browseFile():void
		{
			fileRef.browse(fileFliters);
		}
		
		public function uploadNextFile():void
		{
			var file:IUploadFile = this.findNextFile();
			if (file != null) {
				if (file.uploadUrl != null) {
					file.upload(file.uploadUrl);
				} else {
					file.upload(url);
				}
			} else {
				this.dispatchEvent(new HsUploadEvent(HsUploadEvent.TASK_FINISHED));
			}
		}
		
		
		///////////////////////
		// private functions //
		///////////////////////
		
		private function selectedFilesHandler(evt:Event):void
		{
			var disEvt:HsUploadEvent = new HsUploadEvent(HsUploadEvent.TASK_ADD);
			disEvt.fileList = FileReferenceList(evt.currentTarget);
			this.dispatchEvent(disEvt);
		}
		
		////////////////////////////
		// upload event listeners //
		////////////////////////////
		private function taskAddHandler(evt:HsUploadEvent):void
		{
			var fileList:FileReferenceList = evt.fileList;
			for each (var newFile:FileReference in fileList.fileList) {
				var file:IUploadFile = new uploadFileClass();
				file.file = newFile;
				registerListener(file);
				this.files.addItem(file);
			}
			if (this.status == UploadTaskStatus.FINISHED) {
				this._status = UploadTaskStatus.NOT_START;
			}
			
			if (this.status == UploadTaskStatus.NOT_START && this.isStartAfterSelected) {
				this.dispatchEvent(new HsUploadEvent(HsUploadEvent.TASK_START));
			}
		}
		
		private function taskStartHandler(evt:HsUploadEvent):void
		{
			uploadNextFile();
		}
		
		private function fileStartHandler(evt:HsUploadEvent):void
		{
			this.dispatchEvent(evt);
//			var file:IUploadFile = evt.uploadFile;
//			var urlReq:URLRequest = new URLRequest(url);
//			urlReq.method = URLRequestMethod.POST;
//		//	urlReq.contentType = "multipart/form-data";
//			file.file.upload(urlReq);
		}
		
		private function fileProgressHandler(evt:HsUploadEvent):void
		{
			this.dispatchEvent(evt);
		}
		
		private function fileUploadedHandler(evt:HsUploadEvent):void
		{
			this.dispatchEvent(evt);
		}
		
		private function fileFinishedHandler(evt:HsUploadEvent):void
		{
			this.dispatchEvent(evt);
			if (isAutoControl) {
				this.uploadNextFile();
			}
		}
		
		private function fileDeleteHandler(evt:HsUploadEvent):void
		{
			var file:IUploadFile = evt.uploadFile;
			
			if (file.isDeleted == false) {
				this.dispatchEvent(evt);
			}
			
			if (file.status == UploadFileStatus.NOT_START) {
				unregisterListener(file);
				this.files.removeItemAt(this.files.getItemIndex(file));
			} else if (file.status == UploadFileStatus.PROGRESS) {
				file.file.cancel();
				unregisterListener(file);
				this.files.removeItemAt(this.files.getItemIndex(file));
				if (isAutoControl) {
					this.uploadNextFile();
				}
			} else if (file.status == UploadFileStatus.UPLOADED) {
				file.addEventListener(HsUploadEvent.FILE_FINISHED, fileFinishedAndDeleteHandler);
				this.files.removeItemAt(this.files.getItemIndex(file));
				if (isAutoControl) {
					this.uploadNextFile();
				}	
			} else if (file.status == UploadFileStatus.FINISHED || file.status == UploadFileStatus.FAILED) {
				unregisterListener(file);
				this.files.removeItemAt(this.files.getItemIndex(file));
			} else {
				unregisterListener(file);
				this.files.removeItemAt(this.files.getItemIndex(file));		
			}
			
			file.status = UploadFileStatus.DELETED;
		}
		
		private function fileErrorHandler(evt:HsUploadEvent):void
		{
			this.dispatchEvent(evt);
			if (isAutoControl) {
				this.uploadNextFile();
			}
		}
		
		private function fileFinishedAndDeleteHandler(evt:HsUploadEvent):void
		{
			var file:IUploadFile = IUploadFile(evt.currentTarget);
			file.removeEventListener(HsUploadEvent.FILE_FINISHED_THEN_DELETE, fileFinishedAndDeleteHandler);
			unregisterListener(file);
			var disEvt:HsUploadEvent = new HsUploadEvent(HsUploadEvent.FILE_FINISHED_THEN_DELETE);
			disEvt.evt = evt.evt;
			disEvt.uploadFile = file;
			this.dispatchEvent(disEvt);
		}
		
		///////////
		// utils //
		///////////
		
		private function registerListener(file:IUploadFile):void
		{
			file.addEventListener(HsUploadEvent.FILE_START, fileStartHandler);
			file.addEventListener(HsUploadEvent.FILE_PROGRESS, fileProgressHandler);
			file.addEventListener(HsUploadEvent.FILE_UPLOADED, fileUploadedHandler);
			file.addEventListener(HsUploadEvent.FILE_FINISHED, fileFinishedHandler);
			file.addEventListener(HsUploadEvent.FILE_DELETE, fileDeleteHandler);
			file.addEventListener(HsUploadEvent.FILE_ERROR, fileErrorHandler);	
		}
		
		private function unregisterListener(file:IUploadFile):void
		{
			file.removeEventListener(HsUploadEvent.FILE_START, fileStartHandler);
			file.removeEventListener(HsUploadEvent.FILE_PROGRESS, fileProgressHandler);
			file.removeEventListener(HsUploadEvent.FILE_UPLOADED, fileUploadedHandler);
			file.removeEventListener(HsUploadEvent.FILE_FINISHED, fileFinishedHandler);
			file.removeEventListener(HsUploadEvent.FILE_DELETE, fileDeleteHandler);
			file.removeEventListener(HsUploadEvent.FILE_ERROR, fileErrorHandler);	
		}
		
		private function findNextFile():IUploadFile
		{
			for each (var file:IUploadFile in this.files) {
				if (file.status == UploadFileStatus.NOT_START) {
					this._status = UploadTaskStatus.PROGRESSING;
					trace("[uploadTasksStatus] " + this.status);
					return file;
				}
			}
			if (this.files == null || this.files.length == 0) {
				this._status = UploadTaskStatus.NOT_START;
			} else {
				this._status = UploadTaskStatus.FINISHED;
			}
			trace("[uploadTasksStatus] " + this.status);
			return null;
		}
		
	}
}
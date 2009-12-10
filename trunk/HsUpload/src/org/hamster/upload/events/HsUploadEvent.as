package org.hamster.upload.events
{
	import flash.events.Event;
	import flash.net.FileReferenceList;
	
	import org.hamster.upload.models.IUploadFile;

	public class HsUploadEvent extends Event
	{
		public var uploadFile:IUploadFile;
		
		// events for one file
		public static const FILE_START:String = "CommonUploadEvent_fileStartEvent";
		public static const FILE_PROGRESS:String = "CommonUploadEvent_fileProgressEvent";
		public static const FILE_UPLOADED:String = "CommonUploadEvent_fileUploadedEvent";
		public static const FILE_FINISHED:String = "CommonUploadEvent_fileFinishedEvent";
		// additional
		public static const FILE_DELETE:String = "CommonUploadEvent_fileDeleteEvent";
		// @see UploadFile.isDeleted
		public static const FILE_FINISHED_THEN_DELETE:String = "CommonUploadEvent_fileFinishedThenDeleteEvent";
		public static const FILE_ERROR:String = "CommonUploadEvent_fileErrorEvent";
		
		public var fileList:FileReferenceList;
		
		// events for tasks
		public static const TASK_ADD:String = "CommonUploadEvent_taskAddEvent";
		public static const TASK_START:String = "CommonUploadEvent_taskStartEvent";
		public static const TASK_FINISHED:String = "CommonUploadEvent_taskFinishedEvent";
		
		public var evt:Event;
		
		
		public function HsUploadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:HsUploadEvent = new HsUploadEvent(type, bubbles, cancelable);
			result.uploadFile = uploadFile;
			result.fileList = fileList;
			result.evt = evt;
			return result;
		}
		
	}
}
package org.hamster.upload.events
{
	import flash.events.Event;
	import flash.net.FileReferenceList;
	
	import org.hamster.upload.models.IUploadFile;

	public class HsUploadEvent extends Event
	{
		public var uploadFile:IUploadFile;
		
		// events for one file
		public static const FILE_START:String = "fileStart";
		public static const FILE_PROGRESS:String = "fileProgress";
		public static const FILE_UPLOADED:String = "fileUploaded";
		public static const FILE_FINISHED:String = "fileFinished";
		// additional
		public static const FILE_DELETE:String = "fileDelete";
		// @see UploadFile.isDeleted
		public static const FILE_FINISHED_THEN_DELETE:String = "fileFinishedThenDelete";
		public static const FILE_ERROR:String = "fileError";
		
		public var fileList:FileReferenceList;
		
		// events for tasks
		public static const TASK_ADD:String = "taskAdd";
		public static const TASK_START:String = "taskStart";
		public static const TASK_FINISHED:String = "taskFinished";
		
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
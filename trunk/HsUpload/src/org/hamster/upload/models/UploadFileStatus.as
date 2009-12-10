package org.hamster.upload.models
{
	import mx.events.IndexChangedEvent;
	
	public class UploadFileStatus
	{
		public static const NOT_START:int = 0;
		public static const PROGRESS:int = 1;
		public static const UPLOADED:int = 2;
		public static const FINISHED:int = 3;
		
		public static const FAILED:int = 4;
		// is it necessary??
		public static const DELETED:int = 5;
	}
}
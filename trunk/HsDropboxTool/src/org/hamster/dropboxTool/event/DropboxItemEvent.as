package org.hamster.dropboxTool.event
{
	import flash.events.Event;
	
	import org.hamster.dropbox.models.DropboxFile;
	
	public class DropboxItemEvent extends Event
	{
		public static const DROPBOX_ITEM_SELECTED:String = "dropboxItemSelected";
		
		public var dropboxFile:DropboxFile;
		
		public function DropboxItemEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:DropboxItemEvent = new DropboxItemEvent(type, bubbles, cancelable);
			result.dropboxFile = dropboxFile;
			return result;
		}
	}
}
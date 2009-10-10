package noorg.events
{
	import flash.events.Event;

	public class SelFileEvent extends Event
	{
		public static const DELETE_IMG:String = "SelFileEventDeleteImg";
		
		public function SelFileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
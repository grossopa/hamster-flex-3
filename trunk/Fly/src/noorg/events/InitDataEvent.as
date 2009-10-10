package noorg.events
{
	import flash.events.Event;
	
	public class InitDataEvent extends Event
	{
		public static const INIT_DATA_COMPLETE:String = "InitDataComplete";
		
		public function InitDataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

	}
}
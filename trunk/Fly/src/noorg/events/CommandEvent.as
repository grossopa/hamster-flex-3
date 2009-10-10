package noorg.events
{
	import flash.events.Event;

	public class CommandEvent extends Event
	{
		public static const COMMAND_RESULT:String = "Command_Result";
		public static const COMMAND_FAULT:String = "Command_Fault";
		
		public function CommandEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
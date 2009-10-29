package noorg.magic.events
{
	import flash.events.Event;

	public class StepCtrlEvent extends Event
	{
		public static const NEXT:String = "StepCtrlEventNext";
		public static const PREVIOUS:String = "StepCtrlEventPrevious";
		public static const FINISH:String = "StepCtrlEventFinish";
		
		public function StepCtrlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:StepCtrlEvent = new StepCtrlEvent(type, bubbles, cancelable);
			return result;
		}
		
	}
}
package noorg.events
{
	import flash.events.Event;
	
	import noorg.controls.album.units.PageUnit;

	public class PageUnitEvent extends Event
	{
		public static const SELECT_PAGEUNIT:String = "PageUnitEventSelectPageUnit";
		
		public var curPageUnit:PageUnit;
		
		public function PageUnitEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
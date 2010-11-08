package org.hamster.alive30.menu.event
{
	import flash.events.Event;
	
	import org.hamster.alive30.common.vo.LevelVO;
	
	public class LevelSelectorEvent extends Event
	{
		public static const LEVEL_SELECTED:String = "levelSelected";
		
		
		public var levelVO:LevelVO;
		
		public function LevelSelectorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:LevelSelectorEvent = new LevelSelectorEvent(type, bubbles, cancelable);
			result.levelVO = this.levelVO;
			return result;
		}
		
		
	}
}
package org.hamster.showcase.tool.mediator
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ToolMediator extends Mediator
	{
		public static const NAME:String = "ToolMediator";
		
		public function ToolMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		public function get app():ToolMediator
		{
			return ToolMediator(viewComponent);
		}
	}
}
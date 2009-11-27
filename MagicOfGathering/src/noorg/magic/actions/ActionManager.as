package noorg.magic.actions
{
	import noorg.magic.actions.base.ICardAction;
	import noorg.magic.models.Player;
	
	public class ActionManager
	{
		public var player:Player;
		
		public var actionList:Array;
		
		public function ActionManager()
		{
			actionList = new Array();
		}
		
		public function getAction(index:int):ICardAction
		{
			return ICardAction(actionList[index]);
		}
		
		public function get length():int
		{
			return actionList.length;
		}

	}
}
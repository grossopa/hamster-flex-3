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
		}
		
		public function getAction(index:int):ICardAction
		{
			return ICardAction(actionList[index]);
		}

	}
}
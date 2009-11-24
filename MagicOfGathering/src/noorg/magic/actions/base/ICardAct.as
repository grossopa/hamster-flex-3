package noorg.magic.actions.base
{
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	
	public interface ICardAct
	{
		function set player(value:Player):void;
		function get player():Player;
		function set targetPlayer(value:Player):void;
		function get targetPlayer():Player;
		function set playCard(value:PlayCard):void;
		function get playCard():PlayCard;
		function set targetPlayCard(value:PlayCard):void;
		function get targetPlayCard():PlayCard;
		
		function get actType():String;
		
		function execute():void;
	}
}
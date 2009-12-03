package noorg.magic.models.actions.base
{
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	
	public interface ICardAction
	{
		function set player(value:Player):void;
		function get player():Player;
		function set targetPlayer(value:Player):void;
		function get targetPlayer():Player;
		function set playCard(value:PlayCard):void;
		function get playCard():PlayCard;
		function set targetPlayCard(value:PlayCard):void;
		function get targetPlayCard():PlayCard;
		
		function set affectTargets(value:int):void;
		function get affectTargets():int;
		function get actType():String;
		function get editableAttributes():Array;
		function get descriptionString():String;
		
		function execute():void;
		function afterExecute():void;
		
		function decodeXML(xml:XML):void;
		function encodeXML():XML;
		
		function clone():ICardAction;
	}
}
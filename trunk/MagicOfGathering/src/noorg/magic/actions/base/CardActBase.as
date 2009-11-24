package noorg.magic.actions.base
{
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	
	public class CardActBase implements ICardAct
	{
		private var _player:Player;
		private var _targetPlayer:Player;
		private var _playCard:PlayCard;
		private var _targetPlayCard:PlayCard;
		
		protected var _actType:String;
		
		public function set player(value:Player):void
		{
			this._player = value;
		}
		
		public function get player():Player
		{
			return this._player;
		}
		
		public function set targetPlayer(value:Player):void
		{
			this._targetPlayer = value;
		}
		
		public function get targetPlayer():Player
		{
			return this._targetPlayer;
		}
		
		public function set playCard(value:PlayCard):void
		{
			this._playCard;
		}
		
		public function get playCard():PlayCard
		{
			return this._playCard;
		}
		
		public function set targetPlayCard(value:PlayCard):void
		{
			this._targetPlayCard = value;
		}
		
		public function get targetPlayCard():PlayCard
		{
			return this._targetPlayCard;
		}
		
		public function get actType():String
		{
			return this._actType;
		}
		
		public function CardActBase()
		{
		}
		
		/**
		 * execute command
		 */
		public function execute():void
		{
			
		}

	}
}
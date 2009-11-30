package noorg.magic.actions.base
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	
	public class CardActionBase implements ICardAction
	{
		private var _player:Player;
		private var _targetPlayer:Player;
		private var _playCard:PlayCard;
		private var _targetPlayCard:PlayCard;
		
		private var _affectTargets:int;
		protected var _actType:String;
		
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		protected function get resourceManager():IResourceManager
		{
			return this._resourceManager;
		}
		
		
		public function set affectTargets(value:int):void
		{
			this._affectTargets = value;
		}
		
		public function get affectTargets():int
		{
			return this._affectTargets;
		}
		
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
		
		public function get editableAttributes():Array
		{
			return [];
		}
		
		public function get descriptionString():String
		{
			return "";
		}
		
		public function CardActionBase()
		{
		}
		
		/**
		 * execute command
		 */
		public function execute():void
		{
			
		}
		
		public function decodeXML(xml:XML):void
		{
			this.affectTargets = xml.attribute("affect_targets");
		}
		
		public function encodeXML():XML
		{
			return null;
		}
		
		public function clone():ICardAction
		{
			return null;
		}

	}
}
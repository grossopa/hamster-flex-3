package noorg.magic.models.actions.base
{
	import flash.display.BitmapData;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	import noorg.magic.services.AssetService;
	
	public class CardActionBase implements ICardAction
	{
		public static const AS:AssetService = AssetService.getInstance();
		
		private var _player:Player;
		private var _targetPlayer:Player;
		private var _playCard:PlayCard;
		private var _targetPlayCard:PlayCard;
		
		private var _affectTargets:int;
		
		protected var _actType:String;
		protected var _iconBitmapData:BitmapData;
		
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
			if (this._targetPlayer == null) {
				return this.player;
			}
			return this._targetPlayer;
		}
		
		public function set playCard(value:PlayCard):void
		{
			this._playCard = value;
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
		
		public function get iconBitmapData():BitmapData
		{
			return this._iconBitmapData;
		}
		
		public function CardActionBase()
		{
		}
		
		/**
		 * execute command
		 */
		public function execute():void
		{
			this.validateChanges();
		}
		
		/**
		 * override this function and write changes function here;
		 */
		protected function validateChanges():void
		{
			
		}
		
		/**
		 * after execute, then do something
		 */
		public function afterExecute():void
		{
			
		}
		
		public function decodeXML(xml:XML):void
		{
			this.affectTargets = xml.attribute("affect-targets");
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
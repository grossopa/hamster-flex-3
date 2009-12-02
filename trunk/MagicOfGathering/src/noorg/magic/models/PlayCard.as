package noorg.magic.models
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.actions.base.ICardAction;
	import noorg.magic.events.PlayCardEvent;
	import noorg.magic.events.PlayerEvent;
	import noorg.magic.models.staticValue.CardType;
	
	public class PlayCard extends Card
	{
		private var _location:int;
		private var _status:int;
		private var _player:Player;
		
		[Bindable]
		public var isPoolEnough:Boolean = false;
		
		public const enhancementCards:ArrayCollection = new ArrayCollection();
		
		public function setLocation(value:int, index:int = -1):void
		{
			var locationEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.LOCATION_CHANGED);
			locationEvt.originLocation = this._location;
			locationEvt.index = index;
			_location = value;
			locationEvt.newLocation = this._location;
			this.dispatchEvent(locationEvt);
		}
		
		public function getLocation():int
		{
			return _location;
		}
		
		public function set status(value:int):void
		{
			var statusEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.STATUS_CHANGED);
			statusEvt.originStatus = this.status;
			_status = value;
			statusEvt.newStatus = this.status;
			this.dispatchEvent(statusEvt);
		}
		
		[Bindable]
		public function get status():int
		{
			return _status;
		}
		
		public function get player():Player
		{
			return _player;
		}
		
		public function PlayCard(player:Player)
		{
			super();
			_player = player;
			
			this.actionManager.playCard = this;
			magicPoolChangedHandler(null);
			_player.addEventListener(PlayerEvent.MAGIC_CHANGE, magicPoolChangedHandler);
		}
		
		public function magicPoolChangedHandler(evt:PlayerEvent):void
		{
			if (this.magicPool.white > player.magicWhite) {
				this.isPoolEnough = false;
				return;
			}
			if (this.magicPool.black > player.magicBlack) {
				this.isPoolEnough = false;
				return;
			}
			if (this.magicPool.blue > player.magicBlue) {
				this.isPoolEnough = false;
				return;
			}
			if (this.magicPool.red > player.magicRed) {
				this.isPoolEnough = false;
				return;
			}
			if (this.magicPool.green > player.magicGreen) {
				this.isPoolEnough = false;
				return;
			}
			if (this.magicPool.colorless > player.magicColorless) {
				this.isPoolEnough = false;
				return;
			}
			this.isPoolEnough = true;
		}
		
		public function cast():void
		{
			player.magicBlack 		-= this.magicPool.black;
			player.magicBlue 		-= this.magicPool.blue;
			player.magicColorless 	-= this.magicPool.colorless;
			player.magicGreen 		-= this.magicPool.green;
			player.magicRed 		-= this.magicPool.red;
			player.magicWhite 		-= this.magicPool.white;
			
			this.setLocation(CardType.getDefaultLocation(this.type));
		}
		
		
		public function executeAction(index:int):void
		{
			var iCardAction:ICardAction = this.getAction(index);
			iCardAction.player = this.player;
			iCardAction.playCard = this;
			iCardAction.execute();
		}
		
		
	}
}
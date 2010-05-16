package org.hamster.magic.common.models
{
	import org.hamster.magic.common.events.PlayCardEvent;
	import org.hamster.magic.common.events.PlayerEvent;
	
	[Event(name="locationChanged", type="org.hamster.magic.common.events.PlayCardEvent")]
	[Event(name="statusChanged", type="org.hamster.magic.common.events.PlayCardEvent")]
	[Event(name="enableChanged", type="org.hamster.magic.common.events.PlayCardEvent")]
	// [Event(name="poolEnoughStatusChange", type="org.hamster.magic.common.events.PlayCardEvent")]
	
	public class PlayCard extends Card
	{
		private var _location:int;
		private var _status:int;
		private var _player:Player;
		private var _isPoolEnough:Boolean;
		private var _enabled:Boolean;
		
		public function set enabled(value:Boolean):void
		{
			if (this._enabled != value) {
				this._enabled = value;
				
				var disEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.ENABLE_CHANGED);
				disEvt.card = this;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get enabled():Boolean
		{
			return this._enabled;
		}
		
//		public const enhancementCards:ArrayCollection = new ArrayCollection();
		
		public function setLocation(value:int, index:int = -1):void
		{
			var locationEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.LOCATION_CHANGED);
			locationEvt.card = this;
			locationEvt.oldLocation = this._location;
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
			statusEvt.card = this;
			statusEvt.oldStatus = this.status;
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
		
//		public function set isPoolEnough(value:Boolean):void
//		{
//			if (this._isPoolEnough != value) {
//				this._isPoolEnough = value;
//				var disEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.POOL_ENOUGH_STATUS_CHANGE);
//				disEvt.isPoolEnough = this.isPoolEnough;
//				this.dispatchEvent(disEvt);
//			}
//		}
//		
//		public function get isPoolEnough():Boolean
//		{
//			return this._isPoolEnough;
//		}
		
		public function PlayCard(player:Player)
		{
			super();
			this._player = player;
			
			//this.actionManager.playCard = this;
			// _player.addEventListener(PlayerEvent.MAGIC_CHANGE, magicPoolChangedHandler);
		}
		
//		public function magicPoolChangedHandler(evt:PlayerEvent):void
//		{
//			this.isPoolEnough = this.player.magic.gt(this.magic);
//		}
		
//		public function cast(paid:Boolean = false):void
//		{
//			if (!paid) {
//				if (this.magicPool.colorless == 0) {
//					player.magicBlack 		-= this.magicPool.black;
//					player.magicBlue 		-= this.magicPool.blue;
//				//	player.magicColorless 	-= this.magicPool.colorless;
//					player.magicGreen 		-= this.magicPool.green;
//					player.magicRed 		-= this.magicPool.red;
//					player.magicWhite 		-= this.magicPool.white;
//					
//					if (this.type != null) {
//						this.setLocation(CardType.getDefaultLocation(this.type.type));
//					} else {
//						this.setLocation(CardLocation.CREATURE);
//					}
//				} else {
//					this.payMagic(null);
//				}
//			} else {
//				if (this.type != null) {
//					this.setLocation(CardType.getDefaultLocation(this.type.type));
//				} else {
//					this.setLocation(CardLocation.CREATURE);
//				}
//			}
//			
//		}
		
//		public function executeAction(index:int):void
//		{
//			var iCardAction:ICardAction = this.getAction(index);
//			iCardAction.player = this.player;
//			iCardAction.playCard = this;
//			iCardAction.execute();
//		}
//		
//		private var _payMagicAction:PayMagicAction = new PayMagicAction();
//		
//		private function payMagic(targetAction:ICardAction = null):void
//		{
//			_payMagicAction.playCard = this;
//			_payMagicAction.player = this.player;
//			_payMagicAction.targetAction = targetAction;
//			_payMagicAction.execute();
//		}
//		
		
	}
}
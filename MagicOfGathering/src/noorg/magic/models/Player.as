package noorg.magic.models
{
	import noorg.magic.events.PlayerEvent;
	import noorg.magic.models.base.AbstractModelSupport;
	import noorg.magic.models.staticValue.MagicType;
	
	public class Player extends AbstractModelSupport
	{
		public var name:String;
		
		private var _hp:int = 20;
		
		private var _magicRed:int;
		private var _magicGreen:int;
		private var _magicBlue:int;
		private var _magicBlack:int;
		private var _magicWhite:int;
		private var _magicColorless:int;
		
		// other configurations
		public var color:Number;
		
		public function set hp(value:int):void
		{
			this._hp = value;
			this.dispatchEvent(new PlayerEvent(PlayerEvent.HP_CHANGE));
		}
		
		public function get hp():int
		{
			return this._hp;
		}
		
		public function set magicRed(value:int):void
		{
			if (this._magicRed != value) {
				this._magicRed = value;
				var disEvt:PlayerEvent = new PlayerEvent(PlayerEvent.MAGIC_CHANGE);
				disEvt.magicType = MagicType.RED;
				disEvt.magicCount = value;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get magicRed():int
		{
			return this._magicRed;
		}
		
		public function set magicGreen(value:int):void
		{
			if (this._magicGreen != value) {
				this._magicGreen = value;
				var disEvt:PlayerEvent = new PlayerEvent(PlayerEvent.MAGIC_CHANGE);
				disEvt.magicType = MagicType.GREEN;
				disEvt.magicCount = value;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get magicGreen():int
		{
			return this._magicGreen;
		}
		
		public function set magicBlue(value:int):void
		{
			if (this._magicBlue != value) {
				this._magicBlue = value;
				var disEvt:PlayerEvent = new PlayerEvent(PlayerEvent.MAGIC_CHANGE);
				disEvt.magicType = MagicType.BLUE;
				disEvt.magicCount = value;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get magicBlue():int
		{
			return this._magicBlue;
		}
		
		public function set magicBlack(value:int):void
		{
			if (this._magicBlack != value) {
				this._magicBlack = value;
				var disEvt:PlayerEvent = new PlayerEvent(PlayerEvent.MAGIC_CHANGE);
				disEvt.magicType = MagicType.BLACK;
				disEvt.magicCount = value;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get magicBlack():int
		{
			return this._magicBlack;
		}
		
		public function set magicWhite(value:int):void
		{
			if (this._magicWhite != value) {
				this._magicWhite = value;
				var disEvt:PlayerEvent = new PlayerEvent(PlayerEvent.MAGIC_CHANGE);
				disEvt.magicType = MagicType.WHITE;
				disEvt.magicCount = value;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get magicWhite():int
		{
			return this._magicWhite;
		}
		
		public function set magicColorless(value:int):void
		{
			if (this._magicColorless != value) {
				this._magicColorless = value;
				var disEvt:PlayerEvent = new PlayerEvent(PlayerEvent.MAGIC_CHANGE);
				disEvt.magicType = MagicType.COLORLESS;
				disEvt.magicCount = value;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get magicColorless():int
		{
			return this._magicColorless;
		}
		
		public function get magicAllCount():int
		{
			return this.magicBlack + this.magicBlue + this.magicColorless
					+ this.magicGreen + this.magicRed + this.magicWhite;
		}
		
		
		public var cardColl:CardCollection;
		public var playerCardColl:PlayerCardColl;
		
		
	}
}
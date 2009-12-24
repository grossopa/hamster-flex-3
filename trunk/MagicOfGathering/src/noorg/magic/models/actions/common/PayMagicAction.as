package noorg.magic.models.actions.common
{
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	import noorg.magic.models.actions.base.CardActionBase;
	import noorg.magic.models.actions.base.ICardAction;
	import noorg.magic.utils.GlobalUtil;

	/**
	 * common action to handle all types of cast actions.
	 * 
	 */
	public class PayMagicAction extends CardActionBase
	{	
		public var red:int;
		public var green:int;
		public var blue:int;
		public var black:int;
		public var white:int;
		public var colorless:int;
		
		public var payRed:int;
		public var payGreen:int;
		public var payBlue:int;
		public var payBlack:int;
		public var payWhite:int;
		public var payColorless:int;
		
		private var _targetAction:ICardAction;
		
		/**
		 * cast
		 */
		override public function set playCard(value:PlayCard):void
		{
			super.playCard = value;
			if (this.playCard != null) {
				this.red = playCard.magicPool.red;
				this.green = playCard.magicPool.green;
				this.blue = playCard.magicPool.blue;
				this.black = playCard.magicPool.black;
				this.white = playCard.magicPool.white;
				this.colorless = playCard.magicPool.colorless;
			}
		}
		
		public function set targetAction(value:ICardAction):void
		{
			this._targetAction = value;
		}
		
		public function get targetAction():ICardAction
		{
			return this._targetAction;
		}
		
		public function PayMagicAction()
		{
			super();
		}
		
		override public function execute():void
		{
			var count:int = 0;
			if (player.magicRed > 0) {
				count++;
			}
			if (player.magicGreen > 0) {
				count++;
			}
			if (player.magicBlue > 0) {
				count++;
			}
			if (player.magicBlack > 0) {
				count++;
			}
			if (player.magicWhite > 0) {
				count++;
			}
			
			payRed = red;
			payBlue = blue;
			payGreen = green;
			payBlack = black;
			payWhite = white;
			
			if (colorless > 0) {
				// let user choose how to allocate magics
				GlobalUtil.popupPayColorlessContainer(this);
			} else {
				// directly validate changes
				validateChanges();
			}
		}
		
		override protected function validateChanges():void
		{
			player.magicRed -= payRed;
			player.magicBlue -= payBlue;
			player.magicGreen -= payGreen;
			player.magicBlack -= payBlack;
			player.magicWhite -= payWhite;
			player.magicColorless -= payColorless;
		}
		
		override public function afterExecute():void
		{
			
		}
		
	}
}
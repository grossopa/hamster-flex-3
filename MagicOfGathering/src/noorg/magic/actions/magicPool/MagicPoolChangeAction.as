package noorg.magic.actions.magicPool
{
	import noorg.magic.actions.base.CardActBase;
	import noorg.magic.models.staticValue.ActionType;
	import noorg.magic.utils.Constants;

	public class MagicPoolChangeAction extends CardActBase
	{
		public var color:Number = Constants.COLORLESS;
		public var valueBy:int;
		
		public function MagicPoolChangeAction()
		{
			super();
			this._actType = ActionType.GENERATE_MAGIC;
		}
		
		override public function execute():void
		{
			switch (color) {
				case Constants.BLACK:
				{
					this.targetPlayer.magicBlack += valueBy;
					break;
				}
				case Constants.BLUE:
				{
					this.targetPlayer.magicBlue += valueBy;
					break;
				}
				case Constants.COLORLESS:
				{
					this.targetPlayer.magicColorless += valueBy;
					break;
				}
				case Constants.GREEN:
				{
					this.targetPlayer.magicGreen += valueBy;
					break;
				}
				case Constants.RED:
				{
					this.targetPlayer.magicRed += valueBy;
					break;
				}
				case Constants.WHITE:
				{
					this.targetPlayer.magicWhite += valueBy;
					break;
				}
			}
		}
		
		
	}
}
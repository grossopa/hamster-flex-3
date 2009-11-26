package noorg.magic.actions.magicPool
{
	import noorg.magic.actions.base.CardActionBase;
	import noorg.magic.models.staticValue.ActionType;
	import noorg.magic.utils.Constants;

	public class MagicPoolChangeAction extends CardActionBase
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
		
		override public function decodeXML(xml:XML):void
		{
			this.color = xml.attribute("color");
			this.valueBy = xml.attribute("value-by");
		}
		
		override public function encodeXML():XML
		{
			return new XML(<action type={this.actType} color={this.color}
					value-by={this.valueBy}></action>);
		}
		
	}
}
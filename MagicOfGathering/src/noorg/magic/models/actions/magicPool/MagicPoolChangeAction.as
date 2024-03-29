package noorg.magic.models.actions.magicPool
{
	import flash.display.Bitmap;
	
	import noorg.magic.models.ActionAttribute;
	import noorg.magic.models.Player;
	import noorg.magic.models.actions.base.CardActionBase;
	import noorg.magic.models.actions.base.ICardAction;
	import noorg.magic.models.staticValue.ActionType;
	import noorg.magic.models.staticValue.CardStatus;
	import noorg.magic.utils.Constants;

	public class MagicPoolChangeAction extends CardActionBase
	{
		public var color:String = Constants.COLORLESS;
		public var valueBy:int;
		
		override public function get targetPlayer():Player
		{
			return this.player;
		}
		
		public function MagicPoolChangeAction()
		{
			super();
			
			this._actType = ActionType.MAGIC_POOL_CHANGE;
			this._iconBitmapData = Bitmap(new AS.ActionMagicPoolChange()).bitmapData;
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
			
			afterExecute();
		}
		
		override public function afterExecute():void
		{
			this.playCard.status = CardStatus.PLAY_TAGGED;
		}
		
		override public function get editableAttributes():Array
		{
			var colorObj:ActionAttribute = new ActionAttribute("color", 
					ActionAttribute.TYPE_LIST,
					[Constants.WHITE, Constants.BLACK, Constants.BLUE, 
					Constants.RED, Constants.GREEN, Constants.COLORLESS]);
			var valueByObj:ActionAttribute = new ActionAttribute("valueBy", ActionAttribute.TYPE_INT);
			return [colorObj, valueByObj];
		}
		
		override public function get descriptionString():String
		{
			if (this.valueBy >= 0) {
				return this.resourceManager.getString('action', 
						'cardAction.MagicPoolChange.generate', 
						[this.valueBy, this.resourceManager.getString('main', this.color)]);
			} else {
				return this.resourceManager.getString('action', 
						'cardAction.MagicPoolChange.remove', 
						[this.valueBy, this.resourceManager.getString('main', this.color)]);
			}
		}
		
		override public function decodeXML(xml:XML):void
		{
			super.decodeXML(xml);
			
			this.color = xml.attribute("color");
			this.valueBy = xml.attribute("value-by");
		}
		
		override public function encodeXML():XML
		{
			return new XML(<action act-type={this.actType} color={this.color}
					value-by={this.valueBy} affect-targets={this.affectTargets}></action>);
		}
		
		override public function clone():ICardAction
		{
			var result:MagicPoolChangeAction = new MagicPoolChangeAction();
			result.affectTargets = this.affectTargets;
			result.color = this.color;
			result.valueBy = this.valueBy;
			return result;
		}
		
	}
}
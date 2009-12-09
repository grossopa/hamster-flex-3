package noorg.magic.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import noorg.magic.controls.masks.ProcessMask;
	import noorg.magic.controls.play.unit.PlayCardUnit;
	import noorg.magic.controls.popups.CardDetailPopup;
	import noorg.magic.controls.popups.EnhancementPopup;
	import noorg.magic.controls.popups.GraveyardDetailPopup;
	import noorg.magic.controls.popups.tips.CardDetailTip;
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	
	public class GlobalUtil
	{
		public static var curMask:ProcessMask;
		
		public static function popUpMask(text:String, target:DisplayObject = null):void
		{
			if (target == null) {
				target = app;
			}
			curMask = PopUpManager.createPopUp(target, ProcessMask, true) as ProcessMask;
			curMask.text = text;
			PopUpManager.centerPopUp(curMask);
		}
		
		public static function removePopUpMask():void
		{
			PopUpManager.removePopUp(curMask);
		}
		
		public static function get app():MagicOfGathering
		{
			return MagicOfGathering(Application.application);
		}
		
		public static function createPopup(className:Class, parent:DisplayObject = null):IFlexDisplayObject
		{
			if (parent == null) {
				parent = app;
			}
			var obj:IFlexDisplayObject = PopUpManager.createPopUp(parent, className, true);
			PopUpManager.centerPopUp(obj);
			return obj;
		}
		
		public static function removePopup(obj:IFlexDisplayObject):void
		{
			PopUpManager.removePopUp(obj);
		}
		
		public static function showDetailPopup(playCard:PlayCard):void
		{
			var obj:CardDetailPopup = createPopup(CardDetailPopup) as CardDetailPopup;
			obj.playCard = playCard;
		}
		
		public static function showGraveyardDetailPopup(player:Player, cardLocation:int):void
		{
			var obj:GraveyardDetailPopup = createPopup(GraveyardDetailPopup) as GraveyardDetailPopup;
			obj.cardLocation = cardLocation;
			obj.player = player;
		}
		
		public static function showEnhancementPopup(playCard:PlayCard):void
		{
			var obj:EnhancementPopup = createPopup(EnhancementPopup) as EnhancementPopup;
			obj.playCard = playCard;
		}
		
		public static function showCardDetailTip(playCardUnit:PlayCardUnit):void
		{
			var tip:CardDetailTip = app.cardDetailTip;
			var gPoint:Point = playCardUnit.localToGlobal(new Point());
			var doneFlag:Boolean = false;
			
			if (gPoint.y > tip.heightWithTip) {
				tip.tipArrow.arrowDirection = TipArrowUtil.BOTTOM;
				tip.x = gPoint.x - (tip.width - playCardUnit.width) / 2;
				tip.y = gPoint.y - tip.heightWithTip;
				// to ensure LEFT/RIGHT is a acceptable position, else continue.
				doneFlag = tip.x > 0 && app.width - tip.x - tip.width > 0;
			}
			
			if (!doneFlag && app.height - gPoint.y - playCardUnit.height > tip.heightWithTip) {
				tip.tipArrow.arrowDirection = TipArrowUtil.TOP;
				tip.x = gPoint.x - (tip.width - playCardUnit.width) / 2;
				tip.y = gPoint.y + playCardUnit.height + tip.heightWithTip - tip.height;
				doneFlag = tip.x > 0 && app.width - tip.x - tip.width > 0;
			}
			
			if (!doneFlag && gPoint.x > tip.widthWithTip) {
				tip.tipArrow.arrowDirection = TipArrowUtil.RIGHT;
				tip.x = gPoint.x - tip.widthWithTip;
				tip.y = gPoint.y - playCardUnit.height;
				doneFlag = tip.y > 0 && app.height - tip.y - tip.heightWithTip > 0;
			}
			
			if (!doneFlag && app.width - gPoint.x - playCardUnit.width > tip.widthWithTip) {
				tip.tipArrow.arrowDirection = TipArrowUtil.LEFT;
				tip.x = gPoint.x + playCardUnit.width + tip.widthWithTip - tip.width;
				tip.y = gPoint.y - playCardUnit.height;
				if (tip.y < 0) {
					tip.y = 0;
				} else if (tip.y >= app.height - tip.height) {
					tip.y = app.height - tip.height;
				}
			}
			
			app.cardDetailTip.showTip(playCardUnit);
		}
		
		public static function hideCardDetailTip():void
		{
			app.cardDetailTip.hideTip();
		}
		
	}
}
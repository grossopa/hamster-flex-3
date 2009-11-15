package noorg.magic.utils
{
	import flash.display.DisplayObject;
	
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import noorg.magic.controls.masks.ProcessMask;
	import noorg.magic.controls.popups.CardDetailPopup;
	import noorg.magic.controls.popups.EnhancementPopup;
	import noorg.magic.controls.popups.GraveyardDetailPopup;
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
		
	}
}
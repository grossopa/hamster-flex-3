package noorg.magic.controls.play.renderer
{
	import flash.events.MouseEvent;
	
	import noorg.magic.controls.icons.IconRevert;
	import noorg.magic.controls.play.unit.PlayCardUnit;
	import noorg.magic.events.PlayCardEvent;

	public class EnhancementCardRenderer extends PlayCardUnit
	{
		protected var iconRevert:IconRevert;
		
		public function EnhancementCardRenderer()
		{
			super();
		}
		
		override protected function createIcon():void
		{
			super.createIcon();
			
			this.iconTap.isEnabled = false;
			this.iconEnhancement.isEnabled = false;
			
			iconRevert = new IconRevert();
			iconRevert.visible = false;
			iconRevert.addEventListener(MouseEvent.CLICK, iconRevertClickHandler);
			this.addChild(iconRevert);
			
			this.iconManager.iconArrColl.addItem(iconRevert);
		}
		
		private function iconRevertClickHandler(evt:MouseEvent):void
		{
			var disEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.ENHANCE_CHANGE, true);
			disEvt.card = this.playCard;
			this.dispatchEvent(disEvt);
		}
		
	}
}
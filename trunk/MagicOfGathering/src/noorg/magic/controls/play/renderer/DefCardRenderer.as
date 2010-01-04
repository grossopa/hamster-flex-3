package noorg.magic.controls.play.renderer
{
	import flash.events.MouseEvent;
	
	import noorg.magic.controls.icons.IconRevert;
	import noorg.magic.controls.play.unit.PlayCardUnit;
	import noorg.magic.events.PlayCardEvent;

	public class DefCardRenderer extends PlayCardUnit
	{
		protected var iconRevert:IconRevert;
		
		public function DefCardRenderer()
		{
			super();
		}
		
		override protected function createIcon():void
		{
			super.createIcon();
			
			this.iconCast.isEnabled = false;
			this.iconEnhancement.isEnabled = false;
			this.iconTap.isEnabled = false;
			this.iconQuickMenu.isEnabled = false;
			
			this.dragMaskInsertLeft.isEnabled = false;
			this.dragMaskInsertRight.isEnabled = false;
			this.dragMaskEnhancement.isEnabled = false;
			
//			iconRevert = new IconRevert();
//			iconRevert.addEventListener(MouseEvent.CLICK, iconRevertClickHandler);
//			this.addChild(iconRevert);
//			
//			this.iconManager.iconArrColl.addItem(iconRevert);
		}
		
		private function iconRevertClickHandler(evt:MouseEvent):void
		{
			
		}
		
	}
}
package noorg.magic.controls.icons
{
	public class IconCardQuickMenu extends IconBase
	{
		public function IconCardQuickMenu()
		{
			super();
			this.width = 15;
			this.height = 15;
			drawIcon(AS.IconCardQuickMenu);
			this.isAutoTypeset = false;
		}
		
		/**
		 * because this icon has own different background, so
		 * we override the super drawBackground method to disable 
		 * drawing default background image. 
		 */
		override public function drawBackground():void
		{
			
		}
		
	}
}
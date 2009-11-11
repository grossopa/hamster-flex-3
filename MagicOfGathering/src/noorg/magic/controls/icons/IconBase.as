package noorg.magic.controls.icons
{
	import flash.display.Bitmap;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import noorg.magic.services.AssetService;
	import noorg.magic.utils.Constants;

	public class IconBase extends UIComponent
	{
		public static const AS:AssetService = AssetService.getInstance();
		
		public var isEnabled:Boolean = true;
		
		public function IconBase()
		{
			super();
			
			this.width = Constants.ICON_WIDTH;
			this.height = Constants.ICON_HEIGHT;
			this.buttonMode = true;
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
		}
		
		protected function completeHandler(evt:FlexEvent):void
		{
			this.removeEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
			drawBackground();
		}
		
		public function drawIcon(srcImg:Class):void
		{
			var bm:Bitmap = new srcImg;
			this.graphics.beginBitmapFill(bm.bitmapData);
			this.graphics.drawRect(0, 0, Constants.ICON_WIDTH , Constants.ICON_HEIGHT);
			this.graphics.endFill();
		}
		
		public function drawBackground():void
		{
			var bm:Bitmap = new AS.IconBackground;
			
			this.graphics.beginBitmapFill(bm.bitmapData);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();			
		}
		
		
	}
}
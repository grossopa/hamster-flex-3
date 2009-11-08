package noorg.magic.controls.icons
{
	import flash.display.Bitmap;
	
	import mx.events.FlexEvent;
	
	public class IconTag extends IconBase
	{
		public function IconTag()
		{
			super();
		}
		
		override protected function completeHandler(evt:FlexEvent):void
		{
			super.completeHandler(evt);
			
			var bm:Bitmap = new AS.IconTag;
			this.graphics.beginBitmapFill(bm.bitmapData);
			this.graphics.drawRect(0, 0, 20, 20);
			this.graphics.endFill();
		}
		
	}
}
package noorg.magic.controls.icons
{
	import flash.display.Bitmap;
	
	import mx.events.FlexEvent;
	
	public class IconDetail extends IconBase
	{
		public function IconDetail()
		{
			super();
		}
		
		override protected function completeHandler(evt:FlexEvent):void
		{
			super.completeHandler(evt);
			
			var bm:Bitmap = new AS.IconDetail;
			this.graphics.beginBitmapFill(bm.bitmapData);
			this.graphics.drawRect(0, 0, 20, 20);
			this.graphics.endFill();
		}
		
	}
}
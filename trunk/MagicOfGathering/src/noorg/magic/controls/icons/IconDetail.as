package noorg.magic.controls.icons
{
	import flash.display.Bitmap;
	
	import mx.events.FlexEvent;
	
	import noorg.magic.utils.Constants;
	
	public class IconDetail extends IconBase
	{
		public function IconDetail()
		{
			super();
		}
		
		override protected function completeHandler(evt:FlexEvent):void
		{
			super.completeHandler(evt);
			drawIcon(AS.IconDetail);
		}
		
	}
}
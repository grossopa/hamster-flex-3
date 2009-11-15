package noorg.magic.controls.icons
{
	import mx.events.FlexEvent;
	
	public class IconRevert extends IconBase
	{
		public function IconRevert()
		{
			super();
		}
		
		override protected function completeHandler(evt:FlexEvent):void
		{
			super.completeHandler(evt);
			drawIcon(AS.IconRevert);
		}
		
	}
}
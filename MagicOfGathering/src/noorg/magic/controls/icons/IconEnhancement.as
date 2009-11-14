package noorg.magic.controls.icons
{
	import mx.events.FlexEvent;
	
	public class IconEnhancement extends IconBase
	{
		public function IconEnhancement()
		{
			super();
		}
		
		override protected function completeHandler(evt:FlexEvent):void
		{
			super.completeHandler(evt);
			drawIcon(AS.IconEnhancement);
		}
		
	}
}
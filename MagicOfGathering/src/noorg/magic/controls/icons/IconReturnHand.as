package noorg.magic.controls.icons
{
	import mx.events.FlexEvent;
	
	public class IconReturnHand extends IconBase
	{
		public function IconReturnHand()
		{
			super();
		}
		
		override protected function completeHandler(evt:FlexEvent):void
		{
			super.completeHandler(evt);
			drawIcon(AS.IconReturnHand);
		}
	}
}
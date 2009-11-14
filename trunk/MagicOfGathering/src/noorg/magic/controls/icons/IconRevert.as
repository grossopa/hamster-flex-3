package noorg.magic.controls.icons
{
	public class IconRevert extends IconBase
	{
		public function IconRevert()
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
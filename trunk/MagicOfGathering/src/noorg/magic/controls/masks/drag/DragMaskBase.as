package noorg.magic.controls.masks.drag
{
	import mx.controls.Image;
	import mx.events.FlexEvent;
	
	import noorg.magic.services.AssetService;
	import noorg.magic.utils.Constants;

	public class DragMaskBase extends Image
	{
		protected static const AS:AssetService = AssetService.getInstance();
		
		public function DragMaskBase()
		{
			super();
			this.width = Constants.DRAG_MASK_WIDTH;
			this.height = Constants.DRAG_MASK_HEIGHT;
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);			
		}
		
		protected function completeHandler(evt:FlexEvent):void
		{
			this.removeEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
			
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			this.graphics.beginFill(0xFFFFFF, 0.8);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();
			
		}
		
	}
}
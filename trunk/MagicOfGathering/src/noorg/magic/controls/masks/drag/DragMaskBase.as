package noorg.magic.controls.masks.drag
{
	import mx.controls.Image;
	import mx.effects.Fade;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.managers.DragManager;
	
	import noorg.magic.controls.play.unit.PlayCardUnit;
	import noorg.magic.services.AssetService;
	import noorg.magic.utils.Constants;

	public class DragMaskBase extends Image
	{
		protected static const AS:AssetService = AssetService.getInstance();
		public static const FADE_DURATION:int = 250;
		
		private var _fade:Fade = new Fade();
		
		public var isEnabled:Boolean = true;
		
		public function DragMaskBase()
		{
			super();
			this.width = Constants.DRAG_MASK_WIDTH;
			this.height = Constants.DRAG_MASK_HEIGHT;
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
			this.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
			this.addEventListener(DragEvent.DRAG_EXIT, dragExitHandler);
			this.addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
			
			this.alpha = 0.3;
		}
		
		protected function dragEnterHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit) {
				DragManager.acceptDragDrop(this);
				this.showMask();
			}
		}
		
		protected function dragExitHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit) {
				this.hideMask();
			}
		}
		
		protected function dragDropHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit) {
				this.hideMask();
			}			
		}
		
		protected function completeHandler(evt:FlexEvent):void
		{
			this.removeEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF, 0.8);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();
		}
		
		public function showMask():void
		{
			_fade.stop();
			_fade.target = this;
			_fade.alphaFrom = this.alpha;
			_fade.alphaTo = 1;
			_fade.duration = (1 - this.alpha) * FADE_DURATION;
			_fade.play();
		}
		
		public function hideMask():void
		{
			_fade.stop();
			_fade.target = this;
			_fade.alphaFrom = this.alpha;
			_fade.alphaTo = 0.3;
			_fade.duration = (this.alpha - 0.3) * FADE_DURATION;
			_fade.play();
		}
		
	}
}
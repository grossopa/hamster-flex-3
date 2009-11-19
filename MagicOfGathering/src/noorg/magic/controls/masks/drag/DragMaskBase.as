package noorg.magic.controls.masks.drag
{
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	
	import mx.core.UIComponent;
	import mx.effects.Fade;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import noorg.magic.controls.play.unit.PlayCardUnit;
	import noorg.magic.services.AssetService;
	import noorg.magic.utils.Constants;

	public class DragMaskBase extends UIComponent
	{
		protected static const AS:AssetService = AssetService.getInstance();
		public static const FADE_DURATION:int = 250;
		
		public static const PERCENT_WIDTH:Number = 0.9
		
		private var _iconSource:Class;
		private var _iconWidth:Number;
		private var _iconHeight:Number;
		
		public function set iconSource(value:Class):void {
			_iconSource = value;
			if (value != null) {
				this.invalidateDisplayList();
			}
		}
		public function get iconSource():Class
		{
			return _iconSource;
		}
		
		private var _fade:Fade = new Fade();
		
		public var isEnabled:Boolean = true;
		
		public function DragMaskBase()
		{
			super();
			this.width = Constants.DRAG_MASK_WIDTH;
			this.height = Constants.DRAG_MASK_HEIGHT;
			
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
		
		/**
		 * Should be call inside updateDisplayList.
		 * 
		 * you should only provide the iconSource property or extend this class to 
		 * draw your own DragMask icon.
		 * 
		 */
		protected function drawIcon(uw:Number, uh:Number):void
		{
			if (this.iconSource != null) {
				var bm:Bitmap = new iconSource;
				var m:Matrix = new Matrix();
				var rectWidth:Number = uw * PERCENT_WIDTH;
				m.createBox(rectWidth / bm.width, rectWidth / bm.width, 0, rectWidth, rectWidth);
				m.translate(uw - rectWidth >> 1, uh - rectWidth >> 1);
				this.graphics.beginBitmapFill(bm.bitmapData, m);
				this.graphics.drawRect(uw - rectWidth >> 1, uh - rectWidth >> 1, rectWidth, rectWidth);
				this.graphics.endFill();
			}
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF, 0.8);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();
			
			drawIcon(uw, uh);
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
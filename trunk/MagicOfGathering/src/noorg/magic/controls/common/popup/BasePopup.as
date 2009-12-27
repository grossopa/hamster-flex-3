package noorg.magic.controls.common.popup
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.controls.Text;
	import mx.managers.PopUpManager;
	import mx.utils.GraphicsUtil;
	
	import noorg.magic.controls.common.buttons.popup.CommonPopupCloseButton;

	public class BasePopup extends Canvas
	{
		private var _closeButton:CommonPopupCloseButton;
		private var _titleLabel:Label;
		
		public function BasePopup()
		{
			super();
			
			this.width = 400;
			this.height = 300;
		}
		
		override public function set label(value:String):void
		{
			super.label = value;
			
			if (this._titleLabel != null) {
				this._titleLabel.text = value;
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_closeButton = new CommonPopupCloseButton();
			_closeButton.addEventListener(MouseEvent.CLICK, closeBtnClickHandler);
			this.rawChildren.addChild(_closeButton);
			
			
			var format:TextFormat = new TextFormat();
			format.size = 36;
			format.color = 0xFF1234;
			_titleLabel = new Text();
			_titleLabel.text = this.label;
			_titleLabel.setStyle("right", 10);
			_titleLabel.setStyle("bottom", 10);
			_titleLabel.selectable = false;
			_titleLabel.alpha = 0.3;
			_titleLabel.setStyle("color", 0xFF1234);
			_titleLabel.setStyle("fontSize", 18);
			_titleLabel.setStyle("fontWeight", "bold");
			this.addChild(_titleLabel);
		}
		
		protected function closeBtnClickHandler(evt:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			this._closeButton.move(uw - 45, 0);
			
			this.graphics.lineStyle(3);
			this.graphics.beginFill(0xFFFFFF);
			GraphicsUtil.drawRoundRectComplex(
					this.graphics, 0, 18, uw, uh - 18,
					15, 15, 15, 15);
			this.graphics.endFill();
			
		}
		
	}
}
package org.hamster.showcase.utility.view
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.containers.VBox;
	import mx.controls.Label;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	public class BaseUtilityItemView extends VBox
	{
		protected var _titleLabel:Label = new Label();
		protected var _mainContainer:Canvas = new Canvas();
		protected var _titleLabelContainer:Canvas = new Canvas();
		
		override public function set label(value:String):void
		{
			super.label = value;
			if (_titleLabel) {
				_titleLabel.text = value;
			}
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			if (_titleLabel) {
				_titleLabel.width = value;
			}
		}
		
		public function BaseUtilityItemView()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			//_titleLabelBox = new Label();
			_titleLabel.text = this.label;
			_titleLabel.percentWidth = 100;
			_titleLabel.buttonMode = true;
			_titleLabel.setStyle("verticalCenter", 0);
			
			
			// _titleLabelBox.setStyle("backgroundColor", 0x7f7f7f);
			_titleLabel.setStyle("fontSize", 22);
			_titleLabel.setStyle("fontWeight", "bold");
			_titleLabel.addEventListener(MouseEvent.CLICK, titleLabelBoxClickHandler);
			
			_titleLabelContainer.percentWidth = 100;
			_titleLabelContainer.height = 45;
			_titleLabelContainer.setStyle('backgroundColor', 0x5F99FF);
			_titleLabelContainer.setStyle('backgroundAlpha', 0.6);
			_titleLabelContainer.setStyle("borderStyle", "solid");
			_titleLabelContainer.setStyle("borderWidth", 1);
			_titleLabelContainer.setStyle("borderColor", 0x3E3E3E);
			_titleLabelContainer.addChild(_titleLabel);
			
			this.setStyle("borderStyle", "solid");
			this.setStyle("borderWidth", 1);
			this.setStyle("paddingLeft", 5);
			this.setStyle("paddingTop", 5);
			this.setStyle("paddingRight", 5);
			this.setStyle("paddingBottom", 5);
			
			super.addChildAt(_titleLabelContainer, 0);
			
			//_mainContainer = new VBox();
			_mainContainer.percentWidth = 100;
			_mainContainer.percentHeight = 100;
			
			super.addChildAt(_mainContainer, 1);
			
			super.createChildren();
			
		}
		
		private function titleLabelBoxClickHandler(evt:MouseEvent):void
		{
			_mainContainer.includeInLayout = !_mainContainer.includeInLayout;
			_mainContainer.visible = !_mainContainer.visible;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return _mainContainer.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return _mainContainer.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return _mainContainer.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			return _mainContainer.removeChildAt(index);
		}
		
		override public function setChildIndex(child:DisplayObject, newIndex:int):void
		{
			_mainContainer.setChildIndex(child, newIndex);
		}
	}
}
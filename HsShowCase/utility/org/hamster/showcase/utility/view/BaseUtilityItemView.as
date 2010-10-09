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
		protected var _titleLabelBox:Label = new Label();
		protected var _mainContainer:Canvas = new Canvas();
		
		override public function set label(value:String):void
		{
			super.label = value;
			if (_titleLabelBox) {
				_titleLabelBox.text = value;
			}
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			if (_titleLabelBox) {
				_titleLabelBox.width = value;
			}
		}
		
		public function BaseUtilityItemView()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			//_titleLabelBox = new Label();
			_titleLabelBox.text = this.label;
			_titleLabelBox.percentWidth = 100;
			_titleLabelBox.buttonMode = true;
			_titleLabelBox.addEventListener(MouseEvent.CLICK, titleLabelBoxClickHandler);
			// _titleLabelBox.setStyle("backgroundColor", 0x7f7f7f);
			_titleLabelBox.setStyle("fontSize", 22);
			_titleLabelBox.setStyle("fontWeight", "bold");
			this.setStyle("borderStyle", "solid");
			this.setStyle("borderWidth", 1);
			this.setStyle("paddingLeft", 5);
			this.setStyle("paddingTop", 5);
			this.setStyle("paddingRight", 5);
			this.setStyle("paddingBottom", 5);
			
			super.addChildAt(_titleLabelBox, 0);
			
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
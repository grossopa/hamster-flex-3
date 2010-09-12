package org.hamster.closableTab
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	
	import mx.controls.tabBarClasses.Tab;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	public class HsClosableTab extends Tab
	{
		protected var closeButtonFactory:IFactory = new ClassFactory(HsCloseButton);
		
		private var _closeButton:HsCloseButton;
		
		private var _alwaysShowCloseButton:Boolean;
		private var _closable:Boolean;
		
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			if (_closeButton) {
				_closeButton.visible = value || alwaysShowCloseButton;
			}
		}
		
		public function set alwaysShowCloseButton(value:Boolean):void
		{
			_alwaysShowCloseButton = value;
			_closeButton.visible = value || selected;
		}
		
		[Inspectable(category="General", enumeration="true,false", defaultValue="false")]
		public function get alwaysShowCloseButton():Boolean
		{
			return _alwaysShowCloseButton;
		}
		
		public function set closable(value:Boolean):void
		{
			this._closable = value;
			if (_closeButton) {
				_closeButton.enabled = value;
			}
		}
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="true")]
		public function get closable():Boolean
		{
			return this._closable;
		}
		
		public function HsClosableTab()
		{
			super();
			this.buttonMode = false;
			this.mouseChildren = true;
			
			this.setStyle("textAlign", "left");
		}
		
		override protected function createChildren():void
		{
			_closeButton = new HsCloseButton();
			_closeButton.width = 20;
			_closeButton.height = 20;
			_closeButton.visible = selected || alwaysShowCloseButton;
			_closeButton.enabled = closable;
//			_closeButton.addEventListener(MouseEvent.ROLL_OVER, closeBtnRollOverHandler);
//			_closeButton.addEventListener(MouseEvent.ROLL_OUT, closeBtnRollOutHandler);
//			_closeButton.addEventListener(MouseEvent.MOUSE_DOWN, closeBtnMouseDownHandler);
//			_closeButton.addEventListener(MouseEvent.MOUSE_UP, closeBtnMouseUpHandler);
//			_closeButton.addEventListener(MouseEvent.CLICK, closeBtnClickHandler);
			this.addChildAt(_closeButton, this.numChildren);
			
			super.createChildren();
		}
		
		override protected function measure():void
		{
			super.measure();
			
			if (_closeButton) {
				var cbWidth:Number = 0;
				var cbPadding:Number = getStyle("closeButtonPadding");
				if (isNaN(cbPadding)) {
					cbPadding = 4;
				}
				
				cbWidth = this.measuredHeight - cbPadding * 2;
				if (cbWidth <= 2) cbWidth = 2;
				_closeButton.height = _closeButton.width = cbWidth;
				
				measuredWidth += _closeButton.width + cbPadding * 2;
				this.measuredMinWidth = measuredWidth;
			}
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			if (_closeButton) {
				var cbPadding:Number = getStyle("closeButtonPadding");
				if (isNaN(cbPadding)) {
					cbPadding = 4;
				} else if (cbPadding > (uh - 2) / 2) {
					cbPadding = (uh - 2) / 2;
				}
				_closeButton.move(uw - cbPadding - _closeButton.width, cbPadding);
			}
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var formerParent:DisplayObjectContainer = child.parent;
			if (formerParent && !(formerParent is Loader))
				formerParent.removeChild(child);
			
			var overlayCount:int = 0;
			// If there is an overlay, place the child underneath it.
			if (overlayReferenceCount && child != overlay)
				overlayCount++;
			
			if (_closeButton) {
				if (child != _closeButton)
					super.setChildIndex(_closeButton, super.numChildren - overlayCount);
				overlayCount++;
			}
			
			index = Math.min(index, Math.max(0, super.numChildren - overlayCount));
			
			addingChild(child);
			
			$addChildAt(child, index);
			
			childAdded(child);
			
			return child;
		}
		
		override public function setChildIndex(child:DisplayObject,
											   newIndex:int):void
		{
			// Place the child underneath the overlay.
			var overlayCount:int = 0;
			if (overlayReferenceCount && child != overlay)
				overlayCount++;
			
			if (_closeButton) {
				if (child != _closeButton)
					super.setChildIndex(_closeButton, super.numChildren - overlayCount - 1);
				overlayCount++;
			}
			
			newIndex = Math.min(newIndex, Math.max(0, super.numChildren - overlayCount - 1));
			
			super.setChildIndex(child, newIndex);
		}
		
		override protected function mouseDownHandler(event:MouseEvent):void
		{
			if (event.target == _closeButton) {
			} else {
				super.mouseDownHandler(event);
			}
		}
		
		// issue : cannot catch roll over and roll out event
//		override protected function rollOverHandler(event:MouseEvent):void
//		{
//			if (event.target == _closeButton) {
//				trace ("rollOverHandler" + _closeButton);
//			} else {
//				super.rollOverHandler(event);
//			}			
//		}
//		
//		override protected function rollOutHandler(event:MouseEvent):void
//		{
//			if (event.target == _closeButton) {
//				trace ("rollOutHandler" + _closeButton);
//			} else {
//				super.rollOutHandler(event);
//			}
//		}
		
		override protected function mouseUpHandler(event:MouseEvent):void
		{
			if (event.target == _closeButton) {
			} else {
				super.mouseUpHandler(event);
			}
		}
		
		override protected function clickHandler(event:MouseEvent):void
		{
			if (event.target == _closeButton) {
				var disEvt:HsClosableTabBarEvent = new HsClosableTabBarEvent(HsClosableTabBarEvent.CLOSE_TAB, true);
				disEvt.index = this.parent.getChildIndex(this);
				this.dispatchEvent(disEvt);
			} else {
				super.clickHandler(event);
			}
		}
		
//		protected function closeBtnRollOverHandler(evt:MouseEvent):void
//		{
//		}
//		
//		protected function closeBtnRollOutHandler(evt:MouseEvent):void
//		{
//			
//		}
//		
//		protected function closeBtnMouseDownHandler(evt:MouseEvent):void
//		{
//			
//		}
//		
//		protected function closeBtnMouseUpHandler(evt:MouseEvent):void
//		{
//			
//		}
//		
//		protected function closeBtnClickHandler(evt:MouseEvent):void
//		{
//			
//		}

	}
}
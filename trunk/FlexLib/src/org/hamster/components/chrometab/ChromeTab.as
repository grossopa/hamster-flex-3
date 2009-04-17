package org.hamster.components.chrometab
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.hamster.components.chrometab.unit.ChromeTabUnit;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.ViewStack;
	import mx.controls.Image;
	import mx.core.Application;
	import mx.effects.Move;
	import mx.events.FlexEvent;
	
	public class ChromeTab extends Canvas
	{
		public static const TAB_NUMBER:int = 5;
		public static const TAB_GAP:Number = 195;
		public static const MOVE_DURATION:Number = 200;
		
		public var iTabExtraAction:ITabExtraAction;
		public var newTabName:String = "New Tab";
		
		[Embed(source='assets/new_tab.png')]
		private var new_tab:Class;
		private var _canAddTab:Boolean = true;
		private var _canCloseTab:Boolean = true;
		private var _viewStack:ViewStack;
		private var dragObject:ChromeTabUnit;
		private var mouseDownX:Number;
		private var newTabButton:Image;
		private var newTabIndex:int;
		private var tabArrCol:ArrayCollection;
		
		public function ChromeTab(iTabExtraAction:ITabExtraAction = null)
		{
			super();
			this.iTabExtraAction = iTabExtraAction;
			verticalScrollPolicy = "off";
			horizontalScrollPolicy = "off";
			height = ChromeTabUnit.DEFAULT_HEIGHT;
			setStyle("backgroundColor", 0x569AEE);
			
			tabArrCol = new ArrayCollection();
			var app:Object = Application.application;
			app.addEventListener(MouseEvent.MOUSE_MOVE, tabMouseMoveHandler);
			app.addEventListener(MouseEvent.MOUSE_UP, tabMouseUpHandler);
			app.addEventListener(FlexEvent.APPLICATION_COMPLETE, appCompleteHandler);
			
			newTabButton = new Image();
			newTabButton.width = 30;
			newTabButton.height = 25;
			newTabButton.source = new_tab;
			newTabButton.addEventListener(MouseEvent.CLICK, addTabHandler);
			newTabButton.visible = canAddTab;
			addChildAt(newTabButton, 0);
		}
		
		private function appCompleteHandler(evt:FlexEvent):void
		{
			stage.addEventListener(Event.MOUSE_LEAVE, tabMouseUpHandler);
		}
		
		public function set canAddTab(arg:Boolean):void
		{
			this._canAddTab = arg;
			newTabButton.visible = arg;
		}
		
		public function get canAddTab():Boolean
		{
			return this._canAddTab;
		}
		
		public function set canCloseTab(arg:Boolean):void
		{
			this._canCloseTab = arg;
			for each(var tu:ChromeTabUnit in tabArrCol) {
				tu.closeBtnVisible = arg;
			}
		}
		
		public function get canCloseTab():Boolean
		{
			return this._canCloseTab;
		}
		
		public function set viewStack(arg:ViewStack):void
		{
			tabArrCol = new ArrayCollection();
			removeAllChildren();
			_viewStack = arg;
			if(arg != null && arg.numChildren > 0) {
				for(var i:int = 0; i < _viewStack.numChildren; i++) {
					newTab(i, _viewStack.getChildAt(i).name);
				}
			}
			addChildAt(newTabButton, 0);
			refreshNewTabBtn();
			selectTab(0);
		}
		
		public function get viewStack():ViewStack
		{
			return this._viewStack;
		}
		
		/**
		 * delegation
		 */
		final public function setTabText(contentIndex:int, text:String):void
		{
			ChromeTabUnit(tabArrCol[contentIndex]).labelText = text;
		}
		
		/**
		 * delegation
		 */
		final public function getTabText(contentIndex:int):String
		{
			return ChromeTabUnit(tabArrCol[contentIndex]).labelText;
		}
		
		private function refreshNewTabBtn():void
		{
			setChildIndex(newTabButton, 0);
			newTabButton.x = TAB_GAP * tabArrCol.length + 10;
		}
		
		private function newTab(i:int, nameString:String):void
		{
			var tabUnit:ChromeTabUnit = new ChromeTabUnit(this);
			tabUnit.index = i;
			tabUnit.contentIndex = i;
			tabUnit.x = TAB_GAP * i;
			tabUnit.closeBtnVisible = this._canCloseTab;
			tabUnit.addEventListener(MouseEvent.MOUSE_DOWN, tabMouseDownHandler);
			tabArrCol.addItem(tabUnit);
			setTabText(i, nameString);
			addChildAt(tabUnit, tabArrCol.length - 1);		
		}
		
		private function moveTab(tabUnit:ChromeTabUnit):void
		{
			var move:Move = new Move(tabUnit);
			move.xTo = tabUnit.index * TAB_GAP;
			move.duration = MOVE_DURATION;
			move.play();
		}
		
		private function tabMouseDownHandler(evt:MouseEvent):void
		{
			var curTab:ChromeTabUnit = ChromeTabUnit(evt.currentTarget);
			selectTab(curTab.contentIndex);
			mouseDownX = evt.localX + this.localToGlobal(new Point(x,0)).x;
		}
		
		private function tabMouseMoveHandler(evt:MouseEvent):void
		{
			if(dragObject == null || !evt.buttonDown) {
				tabMouseUpHandler();
				return;
			}
			var curX:Number = evt.stageX - mouseDownX;
			dragObject.x = curX <= 0 ? 0 : curX;
			var index:int = dragObject.index;
			if(curX >= (index + 0.5)* TAB_GAP && index + 1 < tabArrCol.length) {
				var tempTab:ChromeTabUnit = getTabByIndex(index + 1);
				tempTab.index--;
				moveTab(tempTab);
				dragObject.index++;
			} else if(curX <= (index - 0.5) * TAB_GAP && index - 1 >= 0) {
				tempTab = getTabByIndex(index - 1);
				tempTab.index++;
				moveTab(tempTab);
				dragObject.index--;
			}
		}
		
		private function tabMouseUpHandler(evt:Event = null):void
		{
			if(dragObject == null) return;
			moveTab(dragObject);
			dragObject = null;
		}
		
		/**
		 * current location
		 */
		public function getTabByIndex(index:int):ChromeTabUnit
		{
			for each(var tab:ChromeTabUnit in tabArrCol) {
				if(tab.index == index) return tab;
			}
			return null;
		}

		/**
		 * default index
		 */		
		public function getTabByContentIndex(contentIndex:int):ChromeTabUnit
		{
			for each(var tab:ChromeTabUnit in tabArrCol) {
				if(tab.contentIndex == contentIndex) return tab;
			}
			return null;
		}
		
		public function selectTab(index:int):void
		{
			if(iTabExtraAction != null && !iTabExtraAction.beforeSelectTab(index)) {
				return;
			}
			var curTab:ChromeTabUnit = this.getTabByContentIndex(index);
			for each(var tu:ChromeTabUnit in tabArrCol) {
				tu.isSelected = false;
				setChildIndex(tu, tu.index + 1);
			}
			curTab.isSelected = true;
			setChildIndex(curTab, tabArrCol.length);
			refreshNewTabBtn();
			dragObject = curTab;
			
			if(_viewStack != null) {
				_viewStack.selectedIndex = index;
			}
		}
		
		public function closeTab(contentIndex:int):void
		{
			if(iTabExtraAction != null && !iTabExtraAction.beforeCloseTab(contentIndex)) {
				return;
			}
			if(tabArrCol.length <= 1) return;
			var tabUnit:ChromeTabUnit = getTabByContentIndex(contentIndex);
			if(_viewStack != null) _viewStack.removeChildAt(tabUnit.contentIndex);
			removeChild(tabUnit);
			tabArrCol.removeItemAt(tabUnit.contentIndex);
			
			var i:int = 0;
			for each(var tab:ChromeTabUnit in tabArrCol) {
				tab.contentIndex = i;
				if(tab.index > tabUnit.index) {
					tab.index--;
					moveTab(tab);
				}
				i++;
			}
			tabUnit.index != tabArrCol.length
					? selectTab(tabUnit.index)
					: selectTab(tabUnit.index - 1);
			refreshNewTabBtn();
		}
		
		private function addTabHandler(evt:MouseEvent):void
		{
			addTab(newTabName + " " + (++newTabIndex).toString());
		}
		
		public function addTab(text:String):void
		{
			var i:int = tabArrCol.length;
			if(iTabExtraAction != null && !iTabExtraAction.beforeAddTab(i)) {
				return;
			}
			
			newTab(i, text);
			if(_viewStack != null && iTabExtraAction != null) {
				var child:DisplayObject = iTabExtraAction.createViewStackChild();
				if(child != null) _viewStack.addChild(child);
			}
			
			refreshNewTabBtn();
		}
		
	}
	

}
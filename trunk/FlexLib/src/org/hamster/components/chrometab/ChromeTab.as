package org.hamster.components.chrometab
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.ViewStack;
	import mx.controls.Image;
	import mx.core.Application;
	import mx.effects.Move;
	import mx.events.FlexEvent;
	
	import org.hamster.components.chrometab.events.ChromeTabEvent;
	import org.hamster.components.chrometab.unit.ChromeTabUnit;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * A google chrome tab component.
	 * 
	 * you can either use a ViewStack as the main container or custom 
	 * a list of containers as the main container.
	 * 
	 * please implements the interface ITabExtraAction.
	 * @see org.hamster.components.chrometab.ITabExtraAction.as
	 * 
	 * use static (without add/remove child) ViewStack:
	 * use setter function viewStack(value:ViewStack) to pass the reference.
	 * set canAddTab and canCloseTab "false";
	 * 
	 * use a non-static ViewStack or custom select/add/remove event:
	 * implements the interface ITabExtraAction.
	 */
	
	public class ChromeTab extends Canvas
	{
		public static const TAB_GAP:Number = 195;
		public static const MOVE_DURATION:Number = 200;
		
		public var iTabExtraAction:ITabExtraAction;
		// for default new tab name, the format is (NewTabName + count)
		public var newTabName:String = "New Tab";
		
		[Embed(source='assets/new_tab.png')]
		private var new_tab:Class;
		
		//see getter/setter functions
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
			
			// add event listener to the global application to handle the
			// outside mouse event.
			tabArrCol = new ArrayCollection();
			var app:Object = Application.application;
			app.addEventListener(MouseEvent.MOUSE_MOVE, tabMouseMoveHandler);
			app.addEventListener(MouseEvent.MOUSE_UP, tabMouseUpHandler);
			if(stage == null) {
				app.addEventListener(FlexEvent.APPLICATION_COMPLETE, 
						appCompleteHandler);
			} else {
				appCompleteHandler();
			}
			
			newTabButton = new Image();
			newTabButton.width = 30;
			newTabButton.height = 25;
			newTabButton.source = new_tab;
			newTabButton.addEventListener(MouseEvent.CLICK, addTabHandler);
			newTabButton.visible = canAddTab;
			addChildAt(newTabButton, 0);
		}
		
		private function appCompleteHandler(evt:FlexEvent = null):void
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
		
		
		/**
		 * initialize the ViewStack, remove all existing tabs and recreate
		 * them.
		 * 
		 * @param arg viewStack
		 * 
		 */
		public function set viewStack(arg:ViewStack):void
		{
			tabArrCol = new ArrayCollection();
			removeAllChildren();
			_viewStack = arg;
			if(arg != null && arg.numChildren > 0) {
				for(var i:int = 0; i < _viewStack.numChildren; i++) {
					var disObj:DisplayObject = _viewStack.getChildAt(i);
					var txt:String;
					if (disObj.hasOwnProperty("label")) {
						txt = disObj["label"];
					} else {
						txt = disObj.name;
					}
					newTab(i, txt);
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
		 * 
		 * The ChromeTabUnit inside this class is hided.
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
		
		/**
		 * Count new tab button's x location.
		 */
		private function refreshNewTabBtn():void
		{
			setChildIndex(newTabButton, 0);
			newTabButton.x = TAB_GAP * tabArrCol.length + 10;
		}
		
		/**
		 * ChromeTabUnit factory method.
		 */
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
			
			// dispatch tab added event
			this.dispatchEvent(new ChromeTabEvent(ChromeTabEvent.TAB_ADDED));
		}
		
		/**
		 * start to move tab by tab's current index.
		 */
		private function moveTab(tabUnit:ChromeTabUnit):void
		{
			var move:Move = new Move(tabUnit);
			move.xTo = tabUnit.index * TAB_GAP;
			move.duration = MOVE_DURATION;
			move.play();
		}
		
		/**
		 * When user perform a mouse down event to a tab, this function
		 * will be called.  this function will do two things, select current
		 * tab and record mouse Down x location.
		 */
		private function tabMouseDownHandler(evt:MouseEvent):void
		{
			var curTab:ChromeTabUnit = ChromeTabUnit(evt.currentTarget);
			selectTab(curTab.contentIndex);
			mouseDownX = evt.localX + this.localToGlobal(new Point(x,0)).x;
			
			// dispatch event
			var chromeTabEvt:ChromeTabEvent 
					= new ChromeTabEvent(ChromeTabEvent.TAB_SELECTED);
			chromeTabEvt.selectdTab = curTab;
			this.dispatchEvent(chromeTabEvt);
		}
		
		/**
		 * change tabs location if user selected a tab and drag it.
		 */
		private function tabMouseMoveHandler(evt:MouseEvent):void
		{
			if(dragObject == null || !evt.buttonDown) {
				tabMouseUpHandler();
				return;
			}
			var curX:Number = evt.stageX - mouseDownX;
			dragObject.x = curX <= 0 ? 0 : curX;
			var index:int = dragObject.index;

			if (curX >= (index + 0.5)* TAB_GAP 
					&& index + 1 < tabArrCol.length) {
				var tempTab:ChromeTabUnit = getTabByIndex(index + 1);
				tempTab.index--;
				moveTab(tempTab);
				dragObject.index++;
			} else if (curX <= (index - 0.5) * TAB_GAP && index - 1 >= 0) {
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
			
			// dispatch event
			var chromeTabEvt:ChromeTabEvent
					= new ChromeTabEvent(ChromeTabEvent.TAB_END_DRAG);
			chromeTabEvt.selectdTab = dragObject;
			this.dispatchEvent(chromeTabEvt);
			
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
		
		/**
		 * select tab by index.
		 */
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
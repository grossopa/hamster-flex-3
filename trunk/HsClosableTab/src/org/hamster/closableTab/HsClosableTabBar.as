package org.hamster.closableTab
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.controls.TabBar;
	import mx.core.ClassFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	[Style(name="closeButtonPadding", type="Number", inherit="yes")]
	
	[Event(name="closeTab", type="org.hamster.toolkit.base.component.closableTabBar.ClosableTabBarEvent")]
	
	public class HsClosableTabBar extends TabBar
	{
		private var _autoRemoveChild:Boolean = true;
		private var _closable:Boolean = true;
		private var _alwaysShowCloseButton:Boolean = false;
		
		public function set autoRemoveChild(value:Boolean):void { this._autoRemoveChild = value; }
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="true")]
		public function get autoRemoveChild():Boolean { return this._autoRemoveChild; }
		
		public function set closable(value:Boolean):void
		{
			_closable = value;
			
			var children:Array = this.getChildren();
			for each (var child:HsClosableTab in children) {
				child.closable = value;
			}
		}
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="true")]
		public function get closable():Boolean
		{
			return _closable;
		}
		
		public function set alwaysShowCloseButton(value:Boolean):void
		{
			_alwaysShowCloseButton = value;
			
			var children:Array = this.getChildren();
			for each (var child:HsClosableTab in children) {
				child.alwaysShowCloseButton = value;
			}
		}
		
		[Inspectable(category="General", enumeration="true,false", defaultValue="false")]
		public function get alwaysShowCloseButton():Boolean { return _alwaysShowCloseButton; }
		
		public function HsClosableTabBar()
		{
			super();
			navItemFactory = new ClassFactory(HsClosableTab);
		}
		
		
		override protected function createNavItem(label:String, icon:Class=null):IFlexDisplayObject
		{
			var result:HsClosableTab = HsClosableTab(super.createNavItem(label, icon));
			result.closable = closable;
			result.alwaysShowCloseButton = alwaysShowCloseButton;
			return result;
		}
		
//		private function closeTabHandler(evt:ClosableTabBarEvent):void
//		{
//			this.dispatchEvent(evt);
//		}
		
		override protected function clickHandler(event:MouseEvent):void
		{
			if (contains(DisplayObject(event.currentTarget))) {
				super.clickHandler(event);
			}
		}
	}
}
package org.hamster.closableTab
{
	import flash.events.MouseEvent;
	
	import mx.containers.TabNavigator;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.styles.StyleProxy;
	
	[Style(name="closeButtonPadding", type="Number", inherit="yes")]
	
	[Event(name="closeTab", type="org.hamster.closableTab.HsClosableTabEvent")]
	
	public class HsClosableTabNavigator extends TabNavigator
	{
		protected var tabBarClass:IFactory = new ClassFactory(HsClosableTabBar);
		
		private var _autoRemoveChild:Boolean = true;
		private var _alwaysShowCloseButton:Boolean = false;
		private var _closable:Boolean = true;
		
		public function set closable(value:Boolean):void
		{
			if (tabBar) {
				HsClosableTabBar(tabBar).closable = value;
			}
			_closable = value;
		}
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="true")]
		public function get closable():Boolean { return _closable; }
		
		public function set autoRemoveChild(value:Boolean):void
		{
			if (tabBar) {
				HsClosableTabBar(tabBar).autoRemoveChild = value;
			}
			_autoRemoveChild = value;
		}
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="true")]
		public function get autoRemoveChild():Boolean { return _autoRemoveChild; }
		
		public function set alwaysShowCloseButton(value:Boolean):void
		{
			if (tabBar) {
				HsClosableTabBar(tabBar).alwaysShowCloseButton = value;
			}
			_alwaysShowCloseButton = value;
		}
		
		[Inspectable(category="General", enumeration="true,false", defaultValue="false")]
		public function get alwaysShowCloseButton():Boolean { return _alwaysShowCloseButton; }
		
		public function HsClosableTabNavigator()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			if (!tabBar)
			{
				tabBar = tabBarClass.newInstance();
				tabBar.name = "closableTabBar";
				tabBar.focusEnabled = false;
				HsClosableTabBar(tabBar).autoRemoveChild = autoRemoveChild;
				tabBar.styleName = new StyleProxy(this, tabBarStyleFilters);
				tabBar.addEventListener(HsClosableTabEvent.CLOSE_TAB, closeTabHandler);
				rawChildren.addChild(tabBar);
			}
			
			super.createChildren();
		}
		
		protected function closeTabHandler(evt:HsClosableTabEvent):void
		{
			if (!HsClosableTabBar(tabBar).autoRemoveChild) {
				// do nothing
			} else {
				this.removeChildAt(evt.index);
			}
		}
	}
}
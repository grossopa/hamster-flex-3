package org.hamster.toolkit.base.component.closableTabBar
{
	import flash.events.MouseEvent;
	
	import mx.containers.TabNavigator;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.styles.StyleProxy;
	
	[Style(name="closeButtonPadding", type="Number", inherit="yes")]
	
	[Event(name="closeTab", type="org.hamster.toolkit.base.component.closableTabBar.ClosableTabBarEvent")]
	
	public class ClosableTabNavigator extends TabNavigator
	{
		protected var tabBarClass:IFactory = new ClassFactory(ClosableTabBar);
		
		private var _autoRemoveChild:Boolean = true;
		private var _alwaysShowCloseButton:Boolean = false;
		private var _closable:Boolean = true;
		
		public function set closable(value:Boolean):void
		{
			if (tabBar) {
				ClosableTabBar(tabBar).closable = value;
			}
			_closable = value;
		}
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="true")]
		public function get closable():Boolean { return _closable; }
		
		public function set autoRemoveChild(value:Boolean):void
		{
			if (tabBar) {
				ClosableTabBar(tabBar).autoRemoveChild = value;
			}
			_autoRemoveChild = value;
		}
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="true")]
		public function get autoRemoveChild():Boolean { return _autoRemoveChild; }
		
		public function set alwaysShowCloseButton(value:Boolean):void
		{
			if (tabBar) {
				ClosableTabBar(tabBar).alwaysShowCloseButton = value;
			}
			_alwaysShowCloseButton = value;
		}
		
		[Inspectable(category="General", enumeration="true,false", defaultValue="false")]
		public function get alwaysShowCloseButton():Boolean { return _alwaysShowCloseButton; }
		
		public function ClosableTabNavigator()
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
				ClosableTabBar(tabBar).autoRemoveChild = autoRemoveChild;
				tabBar.styleName = new StyleProxy(this, tabBarStyleFilters);
				tabBar.addEventListener(ClosableTabBarEvent.CLOSE_TAB, closeTabHandler);
				rawChildren.addChild(tabBar);
			}
			
			super.createChildren();
		}
		
		protected function closeTabHandler(evt:ClosableTabBarEvent):void
		{
			if (!ClosableTabBar(tabBar).autoRemoveChild) {
				// do nothing
			} else {
				this.removeItemAt(evt.index);
			}
		}
	}
}
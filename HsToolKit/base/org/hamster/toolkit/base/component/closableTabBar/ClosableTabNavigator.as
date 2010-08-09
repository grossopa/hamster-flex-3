package org.hamster.toolkit.base.component.closableTabBar
{
	import flash.events.MouseEvent;
	
	import mx.containers.TabNavigator;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.styles.StyleProxy;
	
	public class ClosableTabNavigator extends TabNavigator
	{
		protected var tabBarClass:IFactory = new ClassFactory(ClosableTabBar);
		
		private var _autoRemoveChild:Boolean = true;
		
		public function set autoRemoveChild(value:Boolean):void
		{
			if (tabBar) {
				ClosableTabBar(tabBar).autoRemoveChild = value;
			}
			_autoRemoveChild = value;
		}
		
		[Inspectable(category="General", enumeration="false,true", defaultValue="true")]
		public function get autoRemoveChild():Boolean
		{
			return _autoRemoveChild;
		}
		
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
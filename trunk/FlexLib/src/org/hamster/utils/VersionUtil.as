package org.hamster.utils
{
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.core.Application;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 	
	public class VersionUtil
	{
		public static function buildVersion(menuText:String):void
		{
			var rightMenu:ContextMenu = new ContextMenu();
			var menu:ContextMenuItem = new ContextMenuItem(menuText);
			rightMenu.hideBuiltInItems();
			rightMenu.customItems.push(menu);
			Application.application.contextMenu = rightMenu;
		}
	}
}
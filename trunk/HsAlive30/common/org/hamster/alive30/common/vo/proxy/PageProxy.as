package org.hamster.alive30.common.vo.proxy
{
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class PageProxy extends Proxy
	{
		public static const NAME:String = "PageProxy";
		
		public static const MENU_MAIN:String = "menu_main";
		public static const MENU_LEVEL_SELECTOR:String = "menu_levelSelector";
		
		public var oldPage:String;
		public var newPage:String;
		
		public function PageProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		
		
	}
}
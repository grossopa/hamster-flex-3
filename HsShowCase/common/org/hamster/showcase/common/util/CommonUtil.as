package org.hamster.showcase.common.util
{
	import org.hamster.showcase.common.facade.AppFacade;
	import org.puremvc.as3.interfaces.IFacade;

	public class CommonUtil
	{
		private static var _facade:IFacade = AppFacade.instance;
		
		public static function set facade(value:IFacade):void
		{
			_facade = value;
		}
		
		public static function get facade():IFacade
		{
			return _facade;
		}
		
		
	}
}
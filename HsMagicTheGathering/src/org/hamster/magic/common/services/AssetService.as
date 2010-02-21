package org.hamster.magic.common.services
{
	public class AssetService
	{
		private static var _instance:AssetService;
		
		public static function getInstance():AssetService
		{
			if (_instance == null) {
				_instance = new AssetService();
			}
			return _instance;
		}
		
		[Embed(source="/org/hamster/magic/common/assets/card/back.png")]
		public var CARD_BACK:Class;

	}
}
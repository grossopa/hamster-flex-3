package org.hamster.alive30.game.model.vo.proxy
{
	import org.hamster.alive30.common.config.AppConfig;
	import org.hamster.alive30.common.constant.AppConstants;
	import org.hamster.alive30.common.facade.AppFacade;
	import org.hamster.alive30.common.vo.proxy.BaseRemoteProxy;
	import org.hamster.alive30.game.model.vo.BulletListVO;
	import org.hamster.alive30.game.model.vo.BulletVO;
	import org.hamster.alive30.game.util.GameConstants;
	
	public class BulletListVOProxy extends BaseRemoteProxy
	{
		public static const NAME:String = "BulletListVOProxy";
		
		public function BulletListVOProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function loadBulletList():void
		{
			super.load("bulletList");
		}
		
		override protected function processResult(xml:XML):void
		{
			var bulletListArray:XMLList = xml.child("bullet-list");
			
			var result:Array = new Array();
			for each (var bulletListsXML:XML in bulletListArray) {
				var bulletListVO:BulletListVO = new BulletListVO();
				bulletListVO.timeGap = bulletListsXML.attribute("time-gap");
				bulletListVO.bulletVOList = [];
				var bulletsXML:XMLList = bulletListsXML.child("bullet");
				for each (var bulletXML:XML in bulletsXML) {
					var bulletVO:BulletVO = new BulletVO();
					bulletVO.x = AppConstants.APP_WIDTH * bulletXML.attribute("px") - GameConstants.BULLET_HIT_RADIUS;
					bulletVO.y = AppConstants.APP_HEIGHT * bulletXML.attribute("py") - GameConstants.BULLET_HIT_RADIUS;
					bulletVO.type = bulletXML.attribute("type");
					bulletVO.moveType = bulletXML.attribute("move-type");
					bulletListVO.bulletVOList.push(bulletVO);
				}
				result.push(bulletListVO);
			}
			
			this.sendNotification(AppFacade.LOAD_BULLET_LIST_DONE, result);
		}
	}
}
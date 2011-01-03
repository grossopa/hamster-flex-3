package org.hamster.mhp3.weapon.vo.proxy
{
	import mx.collections.XMLListCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.hamster.mhp3.common.facade.AppFacade;
	import org.hamster.mhp3.common.util.AppConfig;
	import org.hamster.mhp3.common.vo.proxy.BaseRemoteProxy;
	import org.hamster.services.HTTPServiceLocator;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class WeaponListVOProxy extends BaseRemoteProxy
	{
		public static const NAME:String = "org.hamster.mhp3.main.vo.proxy.WeaponListVOProxy";
		
		public function WeaponListVOProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function loadWeaponList():void
		{
			var httpService:HTTPService = locator.getService("weaponXML");
			var token:AsyncToken = httpService.send();
			token.addResponder(this);
		}
		
		override protected function processResult(xml:XML):void
		{
			var xmlListCollection:XMLListCollection = new XMLListCollection(xml.children());
			AppConfig.weaponImageRootURL = xml.attribute("image-root");
			this.sendNotification(AppFacade.WEAPON_LIST_RESPONSE, xmlListCollection);
		}
		
		
	}
}
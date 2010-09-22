package org.hamster.showcase.main.vo.proxy
{
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import org.hamster.services.HTTPServiceLocator;
	import org.hamster.showcase.common.config.AppConfig;
	import org.hamster.showcase.common.facade.AppFacade;
	import org.hamster.showcase.common.vo.proxy.BaseRemoteProxy;
	import org.hamster.showcase.common.service.MainHTTPService;
	import org.hamster.showcase.common.util.ValidatorUtil;
	import org.hamster.showcase.main.vo.CaseVO;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class CaseVOProxy extends BaseRemoteProxy
	{
		public static const NAME:String = "CaseVOProxy";
		
		public function CaseVOProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function loadCaseList():void
		{
			locator.sendService("caseList", this);
		}
		
		override protected function processResult(xml:XML):void
		{
			var caseVOList:Array = new Array();
			
			var xmlList:XMLList = xml.child("case-list").child("case");
			for each (var x:XML in xmlList) {
				var caseVO:CaseVO = new CaseVO();
				caseVO.id = x.attribute("id");
				caseVO.name = x.attribute("name");
				caseVO.moduleLocation = x.attribute("module-location");
				caseVOList.push(caseVO);
			}
			
			this.sendNotification(AppFacade.UPDATE_CASELIST, caseVOList);
		}
		
		override protected function processFault(xml:XML):void
		{
			
		}
		
	}
}
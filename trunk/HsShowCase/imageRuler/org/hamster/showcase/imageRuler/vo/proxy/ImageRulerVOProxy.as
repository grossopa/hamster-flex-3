package org.hamster.showcase.imageRuler.vo.proxy
{
	import org.hamster.showcase.common.facade.AppFacade;
	import org.hamster.showcase.common.vo.proxy.BaseRemoteProxy;
	import org.hamster.showcase.imageRuler.vo.ImageRulerVO;
	import org.puremvc.as3.interfaces.IProxy;
	
	public class ImageRulerVOProxy extends BaseRemoteProxy
	{
		public static const NAME:String = "ImageRulerVOProxy";
		
		public function ImageRulerVOProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function loadImageSource():void
		{
			locator.sendService("imageRuler", this);
		}
		
		override protected function processResult(xml:XML):void
		{
			var xml:XML = xml.child("image-ruler")[0];
			var vo:ImageRulerVO = new ImageRulerVO();
			vo.id = xml.attribute("id");
			vo.imageSource = xml.attribute("image-source");
			this.sendNotification(AppFacade.UPDATE_RULERIMAGE, vo);
		}
	}
}
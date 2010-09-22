package org.hamster.showcase.imageCropper.vo.proxy
{
	import org.hamster.showcase.common.facade.AppFacade;
	import org.hamster.showcase.common.vo.proxy.BaseRemoteProxy;
	import org.hamster.showcase.imageCropper.vo.CropImageVO;
	
	public class CropImageVOProxy extends BaseRemoteProxy
	{
		public static const NAME:String = "CropImageVOProxy";
		
		public function CropImageVOProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function loadCropImageList():void
		{
			locator.sendService("cropImageList", this);
		}
		
		override protected function processResult(xml:XML):void
		{
			var cropImageVOList:Array = [];
			
			var xmlList:XMLList = xml.child("crop-image-list").child("crop-image");
			for each (var x:XML in xmlList) {
				var cropImageVO:CropImageVO = new CropImageVO();
				cropImageVO.id = x.attribute("id");
				cropImageVO.name = x.attribute("name");
				cropImageVO.location = x.attribute("location");
				cropImageVO.width = x.attribute("width");
				cropImageVO.height = x.attribute("height");
				cropImageVOList.push(cropImageVO);
			}
			
			this.sendNotification(AppFacade.UPDATE_CROPIMAGE, cropImageVOList);
			
		}
	}
}
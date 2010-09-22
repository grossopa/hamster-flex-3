package org.hamster.showcase.imageCropper.mediator
{
	import org.hamster.showcase.common.facade.AppFacade;
	import org.hamster.showcase.imageCropper.command.LoadCropImageListCommand;
	import org.hamster.showcase.imageCropper.vo.CropImageVO;
	import org.hamster.showcase.imageCropper.vo.proxy.CropImageVOProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageCropperModuleMediator extends Mediator
	{
		public static const NAME:String = "ImageCropperModuleMediator";
		
		public function ImageCropperModuleMediator(viewComponent:Object=null)
		{
			super(NAME + viewComponent.toString(), viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.UPDATE_CROPIMAGE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppFacade.UPDATE_CROPIMAGE:
					handleUpdateCropImage(notification);
					break;
			}
		}
		
		private function handleUpdateCropImage(notification:INotification):void
		{
			var cropImageVOList:Array = notification.getBody() as Array;
			var module:ImageCropperModule = ImageCropperModule(this.getViewComponent());
			var sourceArray:Array = [];
			for each (var vo:CropImageVO in cropImageVOList) {
				sourceArray.push(vo.location);
			}
			module.cropImageSourceList = cropImageVOList;
		}
	}
}
package org.hamster.showcase.imageRuler.mediator
{
	import org.hamster.showcase.common.facade.AppFacade;
	import org.hamster.showcase.imageRuler.vo.ImageRulerVO;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageRulerModuleMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ImageRulerModuleMediator";
		
		public function ImageRulerModuleMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.UPDATE_RULERIMAGE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppFacade.UPDATE_RULERIMAGE:
					handleUpdateRulerImage(notification);
					break;
			}
		}
		
		private function handleUpdateRulerImage(notification:INotification):void
		{
			var module:ImageRulerModule = ImageRulerModule(this.getViewComponent());
			module.imageSource = ImageRulerVO(notification.getBody()).imageSource;
		}
	}
}
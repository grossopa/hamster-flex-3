package org.hamster.showcase.imageCropper.command
{
	import org.hamster.showcase.imageCropper.vo.proxy.CropImageVOProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadCropImageListCommand extends SimpleCommand
	{
		public function LoadCropImageListCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var proxy:CropImageVOProxy = CropImageVOProxy(facade.retrieveProxy(CropImageVOProxy.NAME));
			proxy.loadCropImageList();
		}
	}
}
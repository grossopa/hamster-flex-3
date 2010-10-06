package org.hamster.showcase.imageRuler.command
{
	import org.hamster.showcase.imageRuler.vo.proxy.ImageRulerVOProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadImageRulerCommand extends SimpleCommand
	{
		public function LoadImageRulerCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var proxy:ImageRulerVOProxy = ImageRulerVOProxy(facade.retrieveProxy(ImageRulerVOProxy.NAME));
			proxy.loadImageSource();
		}
	}
}
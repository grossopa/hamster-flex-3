package org.hamster.alive30.common.mediator
{
	import flash.display.DisplayObjectContainer;
	
	import mx.core.UIComponent;
	
	import org.puremvc.as3.interfaces.IMediator;
	
	public interface IPageMediator extends IMediator
	{
		function showPage(container:DisplayObjectContainer = null, data:Object = null):void;
		function hidePage(container:DisplayObjectContainer = null, data:Object = null):void;
	}
}
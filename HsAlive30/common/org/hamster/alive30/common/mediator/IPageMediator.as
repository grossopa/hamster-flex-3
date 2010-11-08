package org.hamster.alive30.common.mediator
{
	import mx.core.UIComponent;
	
	import org.puremvc.as3.interfaces.IMediator;
	
	public interface IPageMediator extends IMediator
	{
		function showPage(container:UIComponent = null, data:Object = null):void;
		function hidePage(container:UIComponent = null, data:Object = null):void;
	}
}
// ActionScript file
import flash.display.DisplayObject;
import flash.events.Event;
import flash.net.LocalConnection;

import mx.core.UIComponent;
import mx.events.ModuleEvent;
import mx.modules.IModuleInfo;
import mx.modules.ModuleManager;

private var _moduleInfo:IModuleInfo;

private function appCompleteHandler():void
{
//	var loader:ModuleLoader = new ModuleLoader();
//	loader.url = "/noorg/magic/controls/modules/MenuModule.swf";
//	// loader.addEventListener(ModuleEvent.READY, loadReadyHandler);
//	this.addChild(loader);
	_moduleInfo = ModuleManager.getModule("/noorg/magic/controls/modules/MenuModule.swf");
	_moduleInfo.addEventListener(ModuleEvent.READY, loadReadyHandler);
	_moduleInfo.load();
}

private function loadReadyHandler(evt:ModuleEvent):void
{
	_moduleInfo.removeEventListener(ModuleEvent.READY, loadReadyHandler);
	
	var obj:DisplayObject = evt.module.factory.create() as DisplayObject;
	this.addChild(obj); 
	obj.addEventListener("startGame", aa, false, 0, true);
}


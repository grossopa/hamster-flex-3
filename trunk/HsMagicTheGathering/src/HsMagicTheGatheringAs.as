  // ActionScript file
import flash.display.DisplayObject;
import flash.filesystem.File;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.ModuleEvent;
import mx.modules.IModuleInfo;
import mx.modules.ModuleManager;
 
import org.hamster.commands.events.CommandEvent;
import org.hamster.commands.impl.CommandQueue;
import org.hamster.magic.common.commands.LoadCardsCmd;
import org.hamster.magic.common.commands.LoadConfigureCmd;
import org.hamster.magic.common.commands.LoadUserCollListCmd;
import org.hamster.magic.common.events.HsModuleEvent;
import org.hamster.magic.common.models.CardCollection;
import org.hamster.magic.common.services.DataService;
import org.hamster.magic.common.services.HTTPServices;
import org.hamster.magic.common.utils.Constants;
import org.hamster.magic.common.utils.FileUtil;

private static const DS:DataService = DataService.getInstance();

private var _moduleInfo:IModuleInfo;
private var _currentModule:DisplayObject;

private function appCompleteHandler():void
{
	new HTTPServices();
	
	this.resourceManager.localeChain = ["zh_CN"];
	
	var folders:Array = FileUtil.getCardFolder().getDirectoryListing();
	var collNames:Array = new Array();
	DS.cardCollections = new ArrayCollection();
	
	for each (var folder:File in folders) {
		if (folder.isDirectory) {
			collNames.push(folder.name);
		}
	}
	
	var cmdQueue:CommandQueue = new CommandQueue(null);
	cmdQueue.cmdArray = new Array();
	
	var ldCmd:LoadConfigureCmd = new LoadConfigureCmd();
	cmdQueue.cmdArray.push(ldCmd);
	
	for each (var collection:String in collNames) {
		var loadCardCmd:LoadCardsCmd = new LoadCardsCmd();
		loadCardCmd.collectionName = collection;
		loadCardCmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCardsCompleteHandler);
		cmdQueue.cmdArray.push(loadCardCmd);
	}
	
	var loadListCmd:LoadUserCollListCmd = new LoadUserCollListCmd();
	loadListCmd.addEventListener(CommandEvent.COMMAND_RESULT, loadListCompleteHandler);
	cmdQueue.cmdArray.push(loadListCmd);
	
	cmdQueue.addEventListener(CommandEvent.COMMAND_RESULT, queueCompleteHandler);
	cmdQueue.execute();
}

private function loadCardsCompleteHandler(evt:CommandEvent):void
{
	var cmd:LoadCardsCmd = LoadCardsCmd(evt.currentTarget);
	
	var cardColl:CardCollection = new CardCollection();
	cardColl.name = cmd.collectionName;
	cardColl.cards = new ArrayCollection(cmd.cards);
	DS.cardCollections.addItem(cardColl);
}

private function loadListCompleteHandler(evt:CommandEvent):void
{
	var cmd:LoadUserCollListCmd = LoadUserCollListCmd(evt.currentTarget);
	DS.userCollNames = new ArrayCollection(cmd.names);
}

private function queueCompleteHandler(evt:CommandEvent):void
{
	this.loadModuleHandler(Constants.MENU_MODULE);
}

////////////////////
// module support //
////////////////////

private function loadModuleHandler(str:String):void
{
	_moduleInfo = ModuleManager.getModule(str);
	_moduleInfo.addEventListener(ModuleEvent.READY, moduleReadyHandler);
	_moduleInfo.load();	
}

private function moduleReadyHandler(evt:ModuleEvent):void
{
	_moduleInfo.removeEventListener(ModuleEvent.READY, moduleReadyHandler);
	_currentModule = evt.module.factory.create() as DisplayObject;
	_currentModule.addEventListener(HsModuleEvent.CLOSE, moduleCloseHandler);
	this.addChild(_currentModule);
}

private function moduleCloseHandler(evt:HsModuleEvent):void
{
	_currentModule.removeEventListener(HsModuleEvent.CLOSE, moduleCloseHandler);
	this.removeChild(_currentModule);
	
	_moduleInfo.release();
	loadModuleHandler(evt.nextModule);
}

///////////////////////////
// end of module support //
///////////////////////////


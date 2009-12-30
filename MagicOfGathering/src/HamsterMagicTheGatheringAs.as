// ActionScript file
import flash.display.DisplayObject;

import mx.collections.ArrayCollection;
import mx.events.ModuleEvent;
import mx.modules.IModuleInfo;
import mx.modules.ModuleManager;

import noorg.magic.commands.impl.LoadCardsCmd;
import noorg.magic.commands.impl.LoadUserCollListCmd;
import noorg.magic.commands.impl.init.LoadConfigureCmd;
import noorg.magic.events.GameFlowEvent;
import noorg.magic.models.CardCollection;
import noorg.magic.services.DataService;
import noorg.magic.services.HTTPServices;
import noorg.magic.utils.FileUtil;
import noorg.magic.utils.Constants;

import org.hamster.commands.events.CommandEvent;
import org.hamster.commands.impl.CommandQueue;

public static const DS:DataService = DataService.getInstance();

private var _moduleInfo:IModuleInfo;

private function appCompleteHandler():void
{
	new HTTPServices();
	
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
		loadCardCmd.addEventListener(
				CommandEvent.COMMAND_RESULT, loadCardsCompleteHandler);
		cmdQueue.cmdArray.push(loadCardCmd);
	}
	var loadListCmd:LoadUserCollListCmd = new LoadUserCollListCmd();
	loadListCmd.addEventListener(
			CommandEvent.COMMAND_RESULT, loadListCompleteHandler);
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
	_moduleInfo = ModuleManager.getModule(Constants.MODULE_MENU);
	_moduleInfo.addEventListener(ModuleEvent.READY, menuModuleReadyHandler);
	_moduleInfo.load();
}

private function menuModuleReadyHandler(evt:ModuleEvent):void
{
	_moduleInfo.removeEventListener(ModuleEvent.READY, menuModuleReadyHandler);
	var menuModule:DisplayObject = evt.module.factory.create() as DisplayObject;
	menuModule.addEventListener(GameFlowEvent.START_GAME, startGameHandler);
	this.addChild(menuModule); 
}

private function startGameHandler(evt:GameFlowEvent):void
{
	var menuModule:DisplayObject = DisplayObject(evt.currentTarget);
	menuModule.removeEventListener(GameFlowEvent.START_GAME, startGameHandler);
	this.removeChild(menuModule);
	
	_moduleInfo = ModuleManager.getModule(Constants.MODULE_PLAY);
	_moduleInfo.addEventListener(ModuleEvent.READY, playModuleReadyHandler);
	_moduleInfo.load();
}

private function playModuleReadyHandler(evt:ModuleEvent):void
{
	_moduleInfo.removeEventListener(ModuleEvent.READY, playModuleReadyHandler);
	var playModule:DisplayObject = evt.module.factory.create() as DisplayObject;
	// menuModule.addEventListener(GameFlowEvent.START_GAME, startGameHandler);
	this.addChild(playModule); 
}


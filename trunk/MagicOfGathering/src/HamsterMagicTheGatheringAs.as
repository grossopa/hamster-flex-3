// ActionScript file
import flash.display.DisplayObject;

import mx.collections.ArrayCollection;
import mx.events.ModuleEvent;
import mx.modules.IModuleInfo;
import mx.modules.ModuleManager;

import noorg.magic.commands.impl.LoadCardsCmd;
import noorg.magic.commands.impl.LoadUserCollListCmd;
import noorg.magic.commands.impl.init.LoadConfigureCmd;
import noorg.magic.models.CardCollection;
import noorg.magic.services.DataService;
import noorg.magic.services.HTTPServices;
import noorg.magic.utils.Configures;

import org.hamster.commands.events.CommandEvent;
import org.hamster.commands.impl.CommandQueue;

public static const DS:DataService = DataService.getInstance();

private var _moduleInfo:IModuleInfo;

private function appCompleteHandler():void
{
	new HTTPServices();
	
	var folders:Array = Configures.getCardFolder().getDirectoryListing();
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
	_moduleInfo = ModuleManager.getModule("/noorg/magic/controls/modules/MenuModule.swf");
	_moduleInfo.addEventListener(ModuleEvent.READY, loadReadyHandler);
	_moduleInfo.load();
}

private function loadReadyHandler(evt:ModuleEvent):void
{
	_moduleInfo.removeEventListener(ModuleEvent.READY, loadReadyHandler);
	
	var obj:DisplayObject = evt.module.factory.create() as DisplayObject;
	this.addChild(obj); 
}


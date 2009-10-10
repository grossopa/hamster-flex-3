// ActionScript file
import flash.filesystem.File;

import mx.collections.ArrayCollection;

import noorg.magic.commands.impl.LoadCardsCmd;
import noorg.magic.models.CardCollection;
import noorg.magic.services.DataService;
import noorg.magic.utils.Configures;
import noorg.magic.utils.GlobalUtil;

import org.hamster.commands.events.CommandEvent;
import org.hamster.commands.impl.CommandQueue;

private const DS:DataService = DataService.getInstance();

[Bindable]
private var _curColl:ArrayCollection;

private function completeHandler():void
{
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
	for each (var collection:String in collNames) {
		var loadCardCmd:LoadCardsCmd = new LoadCardsCmd();
		loadCardCmd.collectionName = collection;
		loadCardCmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCardCompletedHandler);
		cmdQueue.cmdArray.push(loadCardCmd);
	}
	cmdQueue.addEventListener(CommandEvent.COMMAND_RESULT, loadCardsCompletedHandler);
	cmdQueue.execute();
	
	GlobalUtil.popUpMask(resourceManager.getString("main", "buildContainer.loadCard"), this);
}

private function loadCardCompletedHandler(evt:CommandEvent):void
{
	var cmd:LoadCardsCmd = LoadCardsCmd(evt.currentTarget);
	
	var cardColl:CardCollection = new CardCollection();
	cardColl.name = cmd.collectionName;
	cardColl.cards = new ArrayCollection(cmd.cards);
	DS.cardCollections.addItem(cardColl);
}

private function loadCardsCompletedHandler(evt:CommandEvent):void
{
	GlobalUtil.removePopUpMask();
	collectionChanged();
}

private function collectionChanged():void
{
	_curColl = CardCollection(this.collectionComboBox.selectedItem).cards;
}
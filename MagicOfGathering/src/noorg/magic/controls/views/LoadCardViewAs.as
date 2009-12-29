// ActionScript file
import mx.controls.Alert;

import noorg.magic.commands.CommandWrapper;
import noorg.magic.commands.impl.GetCardFromWebCmd;
import noorg.magic.models.CardCollectionMeta;
import noorg.magic.utils.Configures;
import noorg.magic.utils.Properties;

import org.hamster.commands.events.CommandEvent;
import org.hamster.commands.impl.CommandQueue;

[Bindable]
private var _curNumber:int;
[Bindable]
private var _totalNumber:int;
[Bindable]
private var _finishedNumber:int;
[Bindable]
private var _failedNumber:int;

private function extract():void
{
	Properties;
	var startIndex:int = int(startIndexInput.text);
	var endIndex:int = int(endIndexInput.text);
	var cmdArray:Array = new Array();
	_curNumber = 1;
	_totalNumber = endIndex - startIndex + 1;
	
	if (_totalNumber > 1000) {
		return;
	}
	for (var i:int = startIndex; i <= endIndex; i++) {
		var cmd:GetCardFromWebCmd = new GetCardFromWebCmd();
		cmd.pid = i;
		cmd.addEventListener(CommandEvent.COMMAND_RESULT, cmdResultHandler);
		cmd.addEventListener(CommandEvent.COMMAND_FAULT, cmdFaultHandler);
		cmdArray.push(cmd);
	}
	
	var cq:CommandQueue = new CommandQueue(cmdArray);
	cq.execute();
}

private function selectKnownCollection():void
{
	var meta:CardCollectionMeta = CardCollectionMeta(collComboBox.selectedItem);
	startIndexInput.text = meta.fromIndex.toString();
	endIndexInput.text = meta.toIndex.toString();
	collectionNameInput.text = meta.name;
}

private function cmdResultHandler(evt:CommandEvent):void
{
	if (_curNumber < _totalNumber) {
		_curNumber++;
	}
	_finishedNumber++;
	var cmd:GetCardFromWebCmd = GetCardFromWebCmd(evt.currentTarget);
	cmd.removeEventListener(CommandEvent.COMMAND_RESULT, cmdResultHandler);
	cmd.removeEventListener(CommandEvent.COMMAND_FAULT, cmdFaultHandler);
	
	CommandWrapper.imgToFile(cmd.card, Configures.getCardFolderByCollection(collectionNameInput.text));
}

private function cmdFaultHandler(evt:CommandEvent):void
{
	if (_curNumber < _totalNumber) {
		_curNumber++;
	}
	_failedNumber++;
	var cmd:GetCardFromWebCmd = GetCardFromWebCmd(evt.currentTarget);
	cmd.removeEventListener(CommandEvent.COMMAND_RESULT, cmdResultHandler);
	cmd.removeEventListener(CommandEvent.COMMAND_FAULT, cmdFaultHandler);
	
	CommandWrapper.imgToFile(cmd.card, Configures.getCardFolderByCollection(collectionNameInput.text));
}// ActionScript file

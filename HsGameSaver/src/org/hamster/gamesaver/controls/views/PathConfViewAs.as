// ActionScript file
import flash.events.Event;
import flash.filesystem.File;

import mx.collections.ArrayCollection;
import mx.controls.Alert;

import org.hamster.commands.events.CommandEvent;
import org.hamster.gamesaver.commands.GenerateZipCmd;
import org.hamster.gamesaver.commands.SaveUserDataCmd;
import org.hamster.gamesaver.models.Game;
import org.hamster.gamesaver.services.DataService;
import org.hamster.gamesaver.utils.FileUtil;

private static const DS:DataService = DataService.getInstance();

[Bindable]
private var _gameArray:ArrayCollection;

private function completeHandler():void
{
	this._gameArray = DS.gameArray;
}

private function browsePath():void
{
	var file:File = new File();
	file.browseForDirectory("123");
	file.addEventListener(Event.SELECT, pathSelectedHandler);
}

private function pathSelectedHandler(evt:Event):void
{
	var file:File = File(evt.currentTarget);
	this.pathInput.text = file.nativePath;
	if (this.nameInput.text == "") {
		this.nameInput.text = file.name;
	}
}

private function browseSavePath():void
{
	var file:File;
	if (this.pathInput.text != "") {
		file = new File(this.pathInput.text);
	} else {
		file = new File();
	}
	
	file.browseForDirectory("123");
	file.addEventListener(Event.SELECT, savePathSelectedHandler);
}

private function savePathSelectedHandler(evt:Event):void
{
	var file:File = File(evt.currentTarget);
	this.savePathInput.text = file.nativePath;
}

private function addHandler():void
{
	var newGame:Game = new Game();
	if (this.nameInput.text == "" 
			|| this.pathInput.text == ""
			|| this.savePathInput.text == "") {
		Alert.show("ddd");
	}
	
	if (!FileUtil.checkPath(this.pathInput.text)
			|| !FileUtil.checkPath(this.savePathInput.text)) {
		Alert.show("eee");		
	}
	newGame.name = this.nameInput.text;
	newGame.path = this.pathInput.text;
	newGame.savePath = this.savePathInput.text;
	newGame.parseIncludes(this.includesInput.text);
	newGame.parseExcludes(this.excludesInput.text);
	
	this._gameArray.addItem(newGame);
}

private function removeSelectedItemHandler():void
{
	if (mainDataGrid.selectedItem == null) {
		return;
	}
	var game:Game = Game(mainDataGrid.selectedItem);
	DS.gameArray.removeItemAt(DS.gameArray.getItemIndex(game));
}

private function saveToFileHandler():void
{
	var cmd:SaveUserDataCmd = new SaveUserDataCmd();
	cmd.addEventListener(CommandEvent.COMMAND_RESULT, saveCompleteHandler);
	cmd.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	cmd.xml = DS.getUserDataXML();
	cmd.execute();
}

private function zipFileHandler():void
{
	var cmd:GenerateZipCmd = new GenerateZipCmd();
	cmd.games = DS.gameArray.toArray();
	cmd.addEventListener(CommandEvent.COMMAND_RESULT, zipCompleteHandler);
	cmd.execute();
}

private function saveCompleteHandler(evt:CommandEvent):void
{
	Alert.show("success");
}

private function zipCompleteHandler(evt:CommandEvent):void
{
	Alert.show("zip success");
}

private function faultHandler(evt:CommandEvent):void
{
	
}
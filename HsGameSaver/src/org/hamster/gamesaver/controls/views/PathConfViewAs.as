// ActionScript file
import flash.events.Event;
import flash.filesystem.File;
import flash.system.System;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.resources.Locale;

import org.hamster.commands.events.CommandEvent;
import org.hamster.gamesaver.commands.GenerateZipCmd;
import org.hamster.gamesaver.commands.SaveUserDataCmd;
import org.hamster.gamesaver.events.CommandProgressEvent;
import org.hamster.gamesaver.models.Game;
import org.hamster.gamesaver.services.DataService;
import org.hamster.gamesaver.utils.FileUtil;
import org.hamster.gamesaver.utils.GlobalUtil;

private static const DS:DataService = DataService.getInstance();

[Bindable]
public var copyPathString:String;
[Bindable]
private var _gameArray:ArrayCollection;

private function completeHandler():void
{
	this._gameArray = DS.gameArray;
}

private function browsePath():void
{
	var file:File = new File();
	file.browseForDirectory(this.resourceManager.getString('main','pathConfView.browsePath'));
	file.addEventListener(Event.SELECT, pathSelectedHandler);
}

private function pathSelectedHandler(evt:Event):void
{
	var file:File = File(evt.currentTarget);
	this.pathInput.text = file.nativePath;
//	if (this.nameInput.text == "") {
//		this.nameInput.text = file.name;
//	}
}

private function browseSavePath():void
{
	var file:File;
	if (this.pathInput.text != "") {
		file = new File(this.pathInput.text);
	} else {
		file = new File();
	}
	
	file.browseForDirectory(this.resourceManager.getString('main','pathConfView.browseSavePath'));
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
		Alert.show(this.resourceManager.getString('main','pathConfView.fullfillData'));
		return;
	}
	
	if (!FileUtil.checkPath(this.pathInput.text)
			|| !FileUtil.checkPath(this.savePathInput.text)) {
		Alert.show(this.resourceManager.getString('main','pathConfView.pathNotAvailable'));
		return;
	}
	var index:int = 1;
	if (DS.isNameExists(this.nameInput.text)) {
		this.nameInput.text = DS.autoIncreaseGameName(this.nameInput.text);
	}
	newGame.name = this.nameInput.text;
	newGame.path = this.pathInput.text;
	newGame.savePath = this.savePathInput.text;
	newGame.includeSubFolder = subFolderCheckBox.selected;
	newGame.parseIncludes(this.includesInput.text);
	newGame.parseExcludes(this.excludesInput.text);
	
	this._gameArray.addItem(newGame);
}

private function localeChangeHandler():void
{
	this.resourceManager.localeChain = [this.localeComboBox.selectedItem];
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
	var saveData:SaveUserDataCmd = new SaveUserDataCmd();
	saveData.xml = DS.getUserDataXML();
	saveData.execute();
	
	var cmd:GenerateZipCmd = new GenerateZipCmd();
	cmd.games = DS.gameArray.toArray();
	cmd.targetZipFolder = DS.copyPath.clone();
	cmd.addEventListener(CommandEvent.COMMAND_RESULT, zipCompleteHandler);
	cmd.addEventListener(CommandProgressEvent.PROGRESS_CHANGE, progressChangeHandler);
	cmd.execute();
	
	for each (var failedGame:Game in cmd.failedGameArray) {
		logHistory.htmlText = "<font color='#FF0000'>" 
				+ this.resourceManager.getString(
						'main', 'pathConfView.logGameFailed',
						[failedGame.name, failedGame.savePath])
				+ "</font><br />";
	}
	
	GlobalUtil.popupLoadingMask(
			this.resourceManager.getString('main','pathConfView.generatingZip'));
}

private function progressChangeHandler(evt:CommandProgressEvent):void
{
//	if (evt.currentResult == "success") {
//		logHistory.htmlText += "<font color='#00FF00'>" 
//				+ this.resourceManager.getString('main', 'pathConfView.logGameSuccess', [failedGame.name]);
//				+ "</font><br />";
//	}
	
	GlobalUtil.setProgress(evt.percent);
}

private function browseCopyPathHandler():void
{
	DS.copyPath.browseForDirectory("");
	DS.copyPath.addEventListener(Event.SELECT, copyPathSelectHandler);
}

private function copyPathSelectHandler(evt:Event):void
{
	DS.copyPath.removeEventListener(Event.SELECT, copyPathSelectHandler);
	this.copyPathInput.text = DS.copyPath.nativePath;
}

private function zipCheckBoxChangeHandler():void
{
	
}

private function saveCompleteHandler(evt:CommandEvent):void
{
	Alert.show("success");
}

private function zipCompleteHandler(evt:CommandEvent):void
{
	GlobalUtil.removeLoadingMask();
	
	var result:String = "";
	var cmd:GenerateZipCmd = GenerateZipCmd(evt.currentTarget);
	if (cmd.targetZipFile != null) {
		result = cmd.targetZipFile.nativePath;
	} else {
		result = DS.copyPath.nativePath;
	}
	Alert.show(this.resourceManager.getString('main', 'pathConfView.zipSuccess', [result]));
}

private function faultHandler(evt:CommandEvent):void
{
	
}
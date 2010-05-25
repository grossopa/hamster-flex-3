// ActionScript file
import mx.containers.Canvas;
import mx.core.Application;
import mx.core.Container;
import mx.core.UIComponent;
import mx.managers.PopUpManager;

import org.hamster.commands.events.CommandEvent;
import org.hamster.gamesaver.commands.GenerateZipCmd;
import org.hamster.gamesaver.commands.SaveUserDataCmd;
import org.hamster.gamesaver.controls.popup.ConfigurePopup;
import org.hamster.gamesaver.controls.units.GameUnit;
import org.hamster.gamesaver.events.ChildComponentEvent;
import org.hamster.gamesaver.events.CommandProgressEvent;
import org.hamster.gamesaver.models.Game;
import org.hamster.gamesaver.services.DataService;
import org.hamster.gamesaver.utils.GlobalUtil;

private var DS:DataService = DataService.getInstance();

private function addGameHandler():void
{
	var newGame:Game = new Game();
	DS.gameArray.addItem(newGame);
	addGameUnit(newGame, true);
}

private function saveButtonClickHandler():void
{
	if (!this.applyChanges()) {
		warningButton.visible = true;
		return;
	}
	warningButton.visible = false;
	
	var saveCmd:SaveUserDataCmd = new SaveUserDataCmd();
	saveCmd.xml = DS.getUserDataXML();
	saveCmd.addEventListener(CommandEvent.COMMAND_RESULT, saveUserDataSuccessHandler);
	saveCmd.addEventListener(CommandEvent.COMMAND_FAULT, saveUserDataFaultHandler);
	saveCmd.execute();
}

private function saveUserDataSuccessHandler(evt:CommandEvent):void
{
	GlobalUtil.alert(
			resourceManager.getString("main","gameContainer.saveUserDataSuccessMessage"), 
			resourceManager.getString("main", "gameContainer.saveUserDataSuccessTitle"));
}

private function saveUserDataFaultHandler(evt:CommandEvent):void
{
	GlobalUtil.alert(
			resourceManager.getString("main","gameContainer.saveUserDataFailedMessage"), 
			resourceManager.getString("main", "gameContainer.saveUserDataFailedTitle"),
			"failed");
}

private function configureButtonClickHandler():void
{
	var disObj:UIComponent = UIComponent(
			PopUpManager.createPopUp(this, ConfigurePopup, true));
	PopUpManager.centerPopUp(disObj);
}

public function addGameUnit(game:Game, isNewGame:Boolean = false):void
{
	var gameUnit:GameUnit = new GameUnit();
	gameUnit.game = game;
	gameUnit.editable = isNewGame;
	gameUnit.addEventListener(ChildComponentEvent.DELETE, gameDeleteHandler);
	this.mainContainer.addChildAt(gameUnit, 0);	
}

private function gameDeleteHandler(evt:ChildComponentEvent):void
{
	var gameUnit:GameUnit = GameUnit(evt.currentTarget);
	gameUnit.removeEventListener(ChildComponentEvent.DELETE, gameDeleteHandler);
	this.mainContainer.removeChild(gameUnit);
	
	var idx:int = DS.gameArray.getItemIndex(gameUnit.game);
		DS.gameArray.removeItemAt(idx);
}

private function generateHandler(isZip:Boolean):void
{
	if (!this.applyChanges()) {
		warningButton.visible = true;
		return;
	}
	warningButton.visible = false;
	var saveCmd:SaveUserDataCmd = new SaveUserDataCmd();
	saveCmd.xml = DS.getUserDataXML();
	saveCmd.execute();
	
	var zipCmd:GenerateZipCmd = new GenerateZipCmd();
	zipCmd.isZipEnabled = isZip;
	zipCmd.targetZipFolder = DS.copyPath.clone();
	zipCmd.games = DS.gameArray.toArray();
	zipCmd.addEventListener(CommandEvent.COMMAND_RESULT, zipCompleteHandler);
	zipCmd.addEventListener(CommandEvent.COMMAND_FAULT, zipFailedHandler);
	zipCmd.addEventListener(CommandProgressEvent.PROGRESS_CHANGE, progressChangeHandler);
	zipCmd.execute();
	GlobalUtil.popupLoadingMask("");
}

private function progressChangeHandler(evt:CommandProgressEvent):void
{
	GlobalUtil.setProgress(evt.percent);
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
	GlobalUtil.alert(this.resourceManager.getString('main', 'gameContainer.zipSuccessMessage', [result]),
			resourceManager.getString("main", "gameContainer.zipSuccessTitle"));
}

private function zipFailedHandler(evt:CommandEvent):void
{
	GlobalUtil.alert(
			resourceManager.getString("main","gameContainer.zipFailedMessage"), 
			resourceManager.getString("main", "gameContainer.zipFailedTitle"),
			"failed");	
}

private function helpHandler():void
{
	GlobalUtil.showHelperPanel();
}

private function expandHandler():void
{
	mainContainer.width = 1220;
	Container(Application.application).width = 1220;
}

public function applyChanges():Boolean
{
	var result:Boolean = true;
	for each (var gameUnit:GameUnit in this.mainContainer.getChildren()) {
		result = gameUnit.applyChanges() && result;
	}
	
	return result;
}
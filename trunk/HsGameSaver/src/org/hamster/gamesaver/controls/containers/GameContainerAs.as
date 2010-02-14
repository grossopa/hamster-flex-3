// ActionScript file
import mx.controls.Alert;
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
	addGameUnit(newGame);
}

private function saveButtonClickHandler():void
{
	applyChanges();
	
	var saveCmd:SaveUserDataCmd = new SaveUserDataCmd();
	saveCmd.xml = DS.getUserDataXML();
	saveCmd.addEventListener(CommandEvent.COMMAND_RESULT, saveUserDataSuccessHandler);
	saveCmd.addEventListener(CommandEvent.COMMAND_FAULT, saveUserDataFaultHandler);
	saveCmd.execute();
}

private function saveUserDataSuccessHandler(evt:CommandEvent):void
{
	
}

private function saveUserDataFaultHandler(evt:CommandEvent):void
{
	
}

private function configureButtonClickHandler():void
{
	var disObj:UIComponent = UIComponent(
			PopUpManager.createPopUp(this, ConfigurePopup, true));
	PopUpManager.centerPopUp(disObj);
}

public function addGameUnit(game:Game):void
{
	var gameUnit:GameUnit = new GameUnit();
	gameUnit.game = game;
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
	this.saveButtonClickHandler()
	
	var zipCmd:GenerateZipCmd = new GenerateZipCmd();
	zipCmd.isZipEnabled = isZip;
	zipCmd.targetZipFolder = DS.copyPath.clone();
	zipCmd.games = DS.gameArray.toArray();
	zipCmd.addEventListener(CommandEvent.COMMAND_RESULT, zipCompleteHandler);
	zipCmd.addEventListener(CommandProgressEvent.PROGRESS_CHANGE, progressChangeHandler);
	zipCmd.execute();
	GlobalUtil.popupLoadingMask(
			this.resourceManager.getString('main','pathConfView.generatingZip'));
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
	Alert.show(this.resourceManager.getString('main', 'pathConfView.zipSuccess', [result]));
}

public function applyChanges():Boolean
{
	var result:Boolean = true;
	for each (var gameUnit:GameUnit in this.mainContainer.getChildren()) {
		result = gameUnit.applyChanges() && result;
	}
	return result;
}
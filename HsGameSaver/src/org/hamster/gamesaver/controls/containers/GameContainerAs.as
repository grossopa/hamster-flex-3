// ActionScript file
import mx.core.UIComponent;
import mx.managers.PopUpManager;

import org.hamster.commands.events.CommandEvent;
import org.hamster.gamesaver.commands.SaveUserDataCmd;
import org.hamster.gamesaver.controls.popup.ConfigurePopup;
import org.hamster.gamesaver.controls.units.GameUnit;
import org.hamster.gamesaver.events.ChildComponentEvent;
import org.hamster.gamesaver.models.Game;
import org.hamster.gamesaver.services.DataService;

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
	saveCmd.addEventListener(CommandEvent.COMMAND_RESULT, saveUserDataFaultHandler);
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
	if (idx != -1) {
		DS.gameArray.removeItemAt(idx);
	}
}

public function applyChanges():void
{
	for each (var gameUnit:GameUnit in this.mainContainer.getChildren()) {
		gameUnit.applyChanges();
	}
}
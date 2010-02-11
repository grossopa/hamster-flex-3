// ActionScript file
import mx.managers.PopUpManager;

import org.hamster.commands.events.CommandEvent;
import org.hamster.gamesaver.commands.LoadUserDataCmd;
import org.hamster.gamesaver.controls.buttons.FolderButton;
import org.hamster.gamesaver.controls.popup.InitConfigPopup;
import org.hamster.gamesaver.services.DataService;

private static const DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	this.resourceManager.localeChain = ["zh_CN"];
 	var loadCmd:LoadUserDataCmd = new LoadUserDataCmd();
	loadCmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCompleteHandler);
	loadCmd.execute();
	if (false) {
		var initConfigPopup:InitConfigPopup = PopUpManager.createPopUp(this, InitConfigPopup, true) as InitConfigPopup;
		PopUpManager.centerPopUp(initConfigPopup);
	}
}

private function loadCompleteHandler(evt:CommandEvent):void
{
	var loadCmd:LoadUserDataCmd = LoadUserDataCmd(evt.currentTarget);
	DS.setUserDataXML(loadCmd.xml);
	//this.pathConfView.copyPathString = DS.copyPath.nativePath;
}
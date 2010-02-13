// ActionScript file
import flash.utils.ByteArray;

import mx.controls.Alert;
import mx.managers.PopUpManager;

import org.hamster.commands.events.CommandEvent;
import org.hamster.gamesaver.commands.LoadUserDataCmd;
import org.hamster.gamesaver.controls.popup.InitConfigPopup;
import org.hamster.gamesaver.services.DataService;

private static const DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	var ddd:String = "我爱天安门，1234567890";
	var dddd:ByteArray = new ByteArray();
	var l:int = 0;
	for (var i:int = 0; i < ddd.length; i++) {
		if (ddd.charCodeAt(i) >= 0 && ddd.charCodeAt(i) <= 128) {
			l += 1;
		} else {
			l += 2;
		}
	}
	dddd.writeUTFBytes(ddd);
	Alert.show(l.toString());
	
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
// ActionScript file
import mx.managers.PopUpManager;

import org.hamster.gamesaver.commands.GenerateZipCmd;
import org.hamster.gamesaver.controls.popup.InitConfigPopup;

private function completeHandler():void
{
	var dd:GenerateZipCmd;
	if (false) {
		var initConfigPopup:InitConfigPopup = PopUpManager.createPopUp(this, InitConfigPopup, true) as InitConfigPopup;
		PopUpManager.centerPopUp(initConfigPopup);
	}
}
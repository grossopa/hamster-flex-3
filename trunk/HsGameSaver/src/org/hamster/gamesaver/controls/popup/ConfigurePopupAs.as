// ActionScript file
import flash.events.Event;

import mx.managers.PopUpManager;

import org.hamster.gamesaver.services.DataService;

private var DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	this.languageComboBox.selectedItem = this.resourceManager.localeChain[0];
	this.targetCopyPathInput.text = DS.copyPath.nativePath;
}

private function browseCopyPathHandler():void
{
	DS.copyPath.addEventListener(Event.SELECT, copyPathSelectHandler);
	DS.copyPath.browseForDirectory("");
}

private function copyPathSelectHandler(evt:Event):void
{
	DS.copyPath.removeEventListener(Event.SELECT, copyPathSelectHandler);
	this.targetCopyPathInput.text = DS.copyPath.nativePath;
}

private function closeSelfHandler():void
{
	if (!this.targetCopyPathInput.checkFilePath()) {
		warningButton.visible = true;
	} else {
		PopUpManager.removePopUp(this);
	}
}

private function languageChangeHandler():void
{
	this.resourceManager.localeChain = [this.languageComboBox.selectedItem.data];
}
// ActionScript file
import flash.events.Event;
import flash.filesystem.File;

import mx.managers.PopUpManager;

import org.hamster.gamesaver.services.DataService;

private var DS:DataService = DataService.getInstance();
[Bindable]
private var locales:Array = [{label:'中文', data: 'zh_CN'},{label:'English', data: 'en_US'}]; 

private function completeHandler():void
{
	var obj:Object = locales[0];
	for each (var o:Object in locales) {
		if (o.data == this.resourceManager.localeChain[0]) {
			obj = o;
			break;
		}
	}
	this.languageComboBox.selectedItem = obj;
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
		var file:File = new File(this.targetCopyPathInput.text);
		file.createDirectory();
		if (!this.targetCopyPathInput.checkFilePath()) {
			warningButton.visible = true;
		} else {
			warningButton.visible = false;
			PopUpManager.removePopUp(this);
		}	
	} else {
		PopUpManager.removePopUp(this);
	}
}

private function languageChangeHandler():void
{
	this.resourceManager.localeChain = [this.languageComboBox.selectedItem.data];
}
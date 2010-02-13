// ActionScript file
import mx.managers.PopUpManager;

private function closeSelfHandler():void
{
	PopUpManager.removePopUp(this);
}

private function languageChangeHandler():void
{
	this.resourceManager.localeChain = [this.languageComboBox.selectedItem.data];
}
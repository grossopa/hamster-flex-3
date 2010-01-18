// ActionScript file

import noorg.magic.services.DataService;
import noorg.magic.services.EventService;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private function completeHandler():void
{
	DS.selectedCards.removeAll();
	validateBtnEnable();
}

private function goNextView():void
{
	if (mainViewStack.selectedIndex < mainViewStack.numChildren - 1) {
		mainViewStack.selectedIndex++;
		validateBtnEnable();
	}
}

private function goPreviousView():void
{
	if (mainViewStack.selectedIndex > 0) {
		mainViewStack.selectedIndex--;
		validateBtnEnable();
	}	
}

private function validateBtnEnable():void
{
	var isCardCollEmpty:Boolean;
	if (DS.cardCollections == null || DS.cardCollections.length == 0) {
		isCardCollEmpty = true;
	}
	
	this.previousBtn.enabled = true;
	this.nextBtn.enabled = true;
	
	if (this.mainViewStack.selectedIndex == 0) {
		this.previousBtn.enabled = false;
		this.nextBtn.enabled = !isCardCollEmpty;
	} else if (this.mainViewStack.selectedIndex == this.mainViewStack.numChildren - 1) {
		this.nextBtn.enabled = false;
	}
}

private function closeView():void
{
	this.hideView();
}
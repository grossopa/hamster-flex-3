// ActionScript file
// ActionScript file
import mx.controls.TabBar;

import noorg.magic.services.DataService;
import noorg.magic.services.EventService;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private function completeHandler():void
{
}

private function goNextView():void
{
	if (mainViewStack.selectedIndex < mainViewStack.numChildren - 1) {
		mainViewStack.selectedIndex++;
	}
}

private function goPreviousView():void
{
	if (mainViewStack.selectedIndex > 0) {
		mainViewStack.selectedIndex--;
	}	
}

private function closeView():void
{
	this.hideView();
}
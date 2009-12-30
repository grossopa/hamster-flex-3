// ActionScript file
import noorg.magic.events.StepCtrlEvent;
import noorg.magic.models.staticValue.CardLocation;
import noorg.magic.services.DataService;

private var DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	this.prepareView.addEventListener(StepCtrlEvent.FINISH, stepFinishHandler);
}

private function stepFinishHandler(evt:StepCtrlEvent):void
{
	this.mainViewStack.selectedIndex = 1;
	mainContainer.players = [DS.playerRed, DS.playerBlue];
}
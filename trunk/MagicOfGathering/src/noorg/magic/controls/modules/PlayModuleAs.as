// ActionScript file
import noorg.magic.events.GameFlowEvent;
import noorg.magic.events.PlayMenuEvent;
import noorg.magic.events.StepCtrlEvent;
import noorg.magic.services.DataService;

private var DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	this.prepareView.addEventListener(StepCtrlEvent.FINISH, stepFinishHandler);
	this.mainContainer.addEventListener(PlayMenuEvent.LEAVE, leaveHandler);
}

private function stepFinishHandler(evt:StepCtrlEvent):void
{
	mainContainer.players = [DS.playerRed, DS.playerBlue];
	this.mainViewStack.selectedIndex = 1;
}

private function leaveHandler(evt:PlayMenuEvent):void
{
	this.dispatchEvent(new GameFlowEvent(GameFlowEvent.QUIT_GAME));
}
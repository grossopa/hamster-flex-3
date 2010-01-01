// ActionScript file
import noorg.magic.events.PlayMenuEvent;
import noorg.magic.services.DataService;

public static const DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	this.playerButton1.player = DS.playerRed;
	this.playerButton2.player = DS.playerBlue;
}

private function playBtn1ClickHandler():void
{
	this.dispatchEvent(new PlayMenuEvent(PlayMenuEvent.SWITCH_PLAYER1));
}

private function playBtn2ClickHandler():void
{
	this.dispatchEvent(new PlayMenuEvent(PlayMenuEvent.SWITCH_PLAYER2));
}

private function leaveBtnClickHandler():void
{
	this.dispatchEvent(new PlayMenuEvent(PlayMenuEvent.LEAVE));
}
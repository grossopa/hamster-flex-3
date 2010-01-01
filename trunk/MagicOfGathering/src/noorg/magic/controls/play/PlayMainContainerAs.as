// ActionScript file
import flash.events.MouseEvent;

import mx.events.DragEvent;
import mx.managers.DragManager;

import noorg.magic.controls.play.unit.PlayCardUnit;
import noorg.magic.events.PlayMenuEvent;
import noorg.magic.models.Player;

private var _players:Array;

public function set players(value:Array):void
{
	_players = value;
	if (this.initialized) {
		this.mainView.player = Player(value[0]);
		this.mainViewOpposite.player = Player(value[1]);
	}
}

public function get players():Array
{
	return _players;
}

private function completeHandler():void
{
	this.players = _players;
	
	this.playMenuContainer.addEventListener(PlayMenuEvent.SWITCH_PLAYER1, switchPlayer1Handler);
	this.playMenuContainer.addEventListener(PlayMenuEvent.SWITCH_PLAYER2, switchPlayer2Handler);
	this.playMenuContainer.addEventListener(PlayMenuEvent.LEAVE, leaveHandler);
//	this.switchPlayerBtnDown.mainButton.addEventListener(MouseEvent.CLICK, downBtnClickHandler);
//	this.switchPlayerBtnUp.mainButton.addEventListener(MouseEvent.CLICK, upBtnClickHandler);
}

private function switchPlayer1Handler(evt:PlayMenuEvent):void
{
	this.mainViewStack.selectedIndex = 0;
}

private function switchPlayer2Handler(evt:PlayMenuEvent):void
{
	this.mainViewStack.selectedIndex = 1;
}

private function leaveHandler(evt:PlayMenuEvent):void
{
	
}

private function upDragEnterHandler(evt:DragEvent):void
{
	if (evt.dragInitiator is PlayCardUnit) {
		//DragManager.acceptDragDrop(switchPlayerBtnUp);
		this.mainViewStack.selectedIndex = 1;
	}
}

private function upDragDropHandler(evt:DragEvent):void
{
	
}

private function downDragEnterHandler(evt:DragEvent):void
{
	if (evt.dragInitiator is PlayCardUnit) {
		//DragManager.acceptDragDrop(switchPlayerBtnDown);
		this.mainViewStack.selectedIndex = 0;
	}	
}

private function downDragDropHandler(evt:DragEvent):void
{
}

private function upBtnClickHandler(evt:MouseEvent):void
{
	this.mainViewStack.selectedIndex = 1;
}

private function downBtnClickHandler(evt:MouseEvent):void
{
	this.mainViewStack.selectedIndex = 0;
}
// ActionScript file
import flash.events.MouseEvent;
import flash.geom.Point;

import mx.managers.CursorManager;

import noorg.magic.events.PlayCardEvent;
import noorg.magic.models.Player;
import noorg.magic.models.staticValue.CardLocation;
import noorg.magic.services.DataService;
import noorg.magic.services.EventService;
import noorg.magic.utils.Constants;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private var _player:Player;

private var _offsetX:int;
private var _offsetY:int;

public function set player(value:Player):void
{
	_player = value;
	if (this.initialized) {
		setPlayer(value);
	}
}

private function setPlayer(value:Player):void
{
	this.playerGallery.player = value;
	this.hpContainer.player = value;
	handList.cardColl = player.playerCardColl.getLocationArray(CardLocation.HAND);
	creatureList.cardColl = player.playerCardColl.getLocationArray(CardLocation.CREATURE);
}

public function get player():Player
{
	return _player;
}

private function completeHandler():void
{
	setPlayer(player);
	
	ES.addEventListener(PlayCardEvent.DRAW_CARD, dragCardHandler);
	
	var p:Point = this.localToGlobal(new Point(0, 0));
	_offsetX = p.x;
	_offsetY = p.y;
}

private function dragCardHandler(evt:PlayCardEvent):void
{
	//CursorManager.hideCursor();
	//this.dragCardUnit.card = evt.card;
	//this.dragCardUnit.visible = true;
}

private function mouseMoveHandler(evt:MouseEvent):void
{
//	if (this.dragCardUnit.visible = true) {
//		this.dragCardUnit.x = evt.stageX - _offsetX - Constants.PLAY_CARD_WIDTH / 2;
//		this.dragCardUnit.y = evt.stageY - _offsetY - Constants.PLAY_CARD_HEIGHT / 2;
//	}
}

private function moveDownHandler():void
{
	
}

private function moveUpHandler():void
{
	
}
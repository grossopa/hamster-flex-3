// ActionScript file
import flash.events.MouseEvent;

import org.hamster.magic.common.models.Player;
import org.hamster.magic.play.controls.units.PlayCardPileUnit;

private var _player:Player;

public function set player(value:Player):void
{
	this._player = value;
}

public function get player():Player
{
	return this._player;
}

private function changeFocusHandler(evt:MouseEvent):void
{
	var unit:PlayCardPileUnit = PlayCardPileUnit(evt.currentTarget);
	galleryPileUnit.isSelected = false;
	graveyardPileUnit.isSelected = false;
	outPileUnit.isSelected = false;
	unit.isSelected = true;
}

private function drawButtonClickHandler():void
{
	this.player.playerCards.drawCard();
}
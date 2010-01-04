// ActionScript file
import flash.display.DisplayObject;

import mx.collections.ArrayCollection;
import mx.core.Application;
import mx.managers.PopUpManager;

import noorg.magic.controls.play.popups.actions.AttackPopup;
import noorg.magic.models.PlayCard;
import noorg.magic.models.Player;
import noorg.magic.models.staticValue.CardLocation;
import noorg.magic.models.staticValue.CardStatus;

private var _player:Player;

public function set player(value:Player):void
{
	this._player = value;
}

public function get player():Player
{
	return this._player;
}

private function untapAll():void
{
	var tappedArr:ArrayCollection = new ArrayCollection(
			this._player.playerCardColl.getStatusArray(
					CardStatus.PLAY_TAGGED).toArray());
	for each (var playCard:PlayCard in tappedArr) {
		playCard.status = CardStatus.PLAY;
	}
}

private function tapAllLand():void
{
	var landArr:ArrayCollection = this._player.playerCardColl
			.getLocationArray(CardLocation.LAND);
	for each (var playCard:PlayCard in landArr) {
		// PROMISE: 1
		if (playCard.status != CardStatus.PLAY_TAGGED) {
			playCard.executeAction(0);
		}
	}	
}

private function beginAttack():void
{
	var attPopup:AttackPopup = PopUpManager.createPopUp(Application.application as DisplayObject, AttackPopup, true) as AttackPopup;
	attPopup.setPlayers(this.player, this.player);
	PopUpManager.centerPopUp(attPopup);
}
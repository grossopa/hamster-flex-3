// ActionScript file
import mx.collections.ArrayCollection;

import noorg.magic.models.PlayCard;
import noorg.magic.models.Player;
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
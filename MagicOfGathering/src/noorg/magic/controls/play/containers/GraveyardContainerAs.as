// ActionScript file
import mx.collections.ArrayCollection;

import noorg.magic.models.Player;
import noorg.magic.models.staticValue.CardLocation;

private var _player:Player;

private var _cardColl:ArrayCollection;

public function set player(value:Player):void
{
	this._player = value;
	_cardColl = player.playerCardColl.getLocationArray(CardLocation.GRAVEYARD);
}

public function get player():Player
{
	return this._player;
}


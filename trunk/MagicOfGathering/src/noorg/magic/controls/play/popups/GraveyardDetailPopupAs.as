// ActionScript file
import mx.collections.ArrayCollection;

import noorg.magic.models.Player;
import noorg.magic.models.staticValue.CardLocation;
import noorg.magic.utils.GlobalUtil;

[Bindable]
private var _cardColl:ArrayCollection;
private var _player:Player;

public var cardLocation:int;

public function set player(value:Player):void
{
	this._player = value;
	
//	if (this._cardColl != null) {
//		this._cardColl.removeEventListener(CollectionEvent.COLLECTION_CHANGE, cardCollChangeHandler);
//	}
	this._cardColl = value.playerCardColl.getLocationArray(cardLocation);
}

public function get player():Player
{
	return this._player;
}

//private function cardCollChangeHandler(evt:CollectionEvent):void
//{
//	
//}

private function closeHandler():void
{
	GlobalUtil.removePopup(this);
}

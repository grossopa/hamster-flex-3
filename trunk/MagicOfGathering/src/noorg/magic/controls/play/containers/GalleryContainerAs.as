// ActionScript file
import mx.controls.Image;
import mx.core.DragSource;
import mx.managers.DragManager;

import noorg.magic.models.PlayCard;
import noorg.magic.models.Player;
import noorg.magic.utils.Constants;

import org.hamster.utils.ImageUtil;Constants;

private var _player:Player;

public function get player():Player
{
	return _player;
}

public function set player(value:Player):void
{
	this._player = value;
}

private function completeHandler():void
{
}

private function backClickHandler():void
{
	dragCard();
}

public function dragCard():PlayCard
{
	return player.playerCardColl.dragCard();
}

// ActionScript file
import noorg.magic.models.PlayCard;
import noorg.magic.utils.Constants;Constants;

private var _playCard:PlayCard;

override public function set data(value:Object):void
{
	_playCard = PlayCard(value);
	if (this.initialized) {
		this.playCardUnit.card = _playCard;
	}
}

override public function get data():Object
{
	return _playCard;
}

private function completeHandler():void
{
	this.playCardUnit.card = _playCard;
}
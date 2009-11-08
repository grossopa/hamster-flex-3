// ActionScript file
import noorg.magic.models.PlayCard;
import noorg.magic.utils.GlobalUtil;

private var _playCard:PlayCard;

public function set playCard(value:PlayCard):void
{
	this._playCard = value;
	
	if (this.mainCardDetailContainer != null) {
		this.mainCardDetailContainer.card = value;
		this.title = value.name;
	}
}

[Bindable]
public function get playCard():PlayCard
{
	return this._playCard;
}

private function completeHandler():void
{
	if (playCard != null) {
		this.mainCardDetailContainer.card = playCard;
		this.title = playCard.name;
	}
}

public function closeHandler():void
{
	GlobalUtil.removePopup(this);
}
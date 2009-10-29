// ActionScript file
import noorg.magic.models.CardCollection;
import noorg.magic.models.Player;
import noorg.magic.models.staticValue.CardLocation;
import noorg.magic.services.DataService;


private const DS:DataService = DataService.getInstance();

private var _player:Player;
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
	this.handList.cardColl = player.playerCardColl.getLocationArray(CardLocation.HAND);
}

public function get player():Player
{
	return _player;
}

private function completeHandler():void
{
	setPlayer(player);
}

private function moveDownHandler():void
{
	
}

private function moveUpHandler():void
{
	
}
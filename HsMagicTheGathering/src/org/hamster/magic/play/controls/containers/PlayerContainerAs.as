// ActionScript file
import org.hamster.magic.common.models.Player;
import org.hamster.magic.common.models.utils.CardLocation;

private var _player:Player;

public function set player(value:Player):void
{
	this._player = value;
}

public function get player():Player
{
	return this._player;
}

private function completeHandler():void
{
	this.playCardPileContainer.player = this.player;
}

private function completeHandler2():void
{
	creatureContainer.cardArray = this.player.playerCards.getLocationArray(CardLocation.CREATURE);
	artifactContainer.cardArray = this.player.playerCards.getLocationArray(CardLocation.ARTIFACT);
	landContainer.cardArray = this.player.playerCards.getLocationArray(CardLocation.LAND);
	handContainer.cardArray = this.player.playerCards.getLocationArray(CardLocation.HAND);
}

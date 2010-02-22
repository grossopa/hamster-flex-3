// ActionScript file
import org.hamster.magic.common.models.Player;

private var _player:Player;

public function set player(value:Player):void
{
	this._player = value;
	if (this.initialized) {
		this.lifeUnit.player = value;
		this.magicUnit.magic = value.magic;
	}
}

public function get player():Player
{
	return this._player;
}

private function completeHandler():void
{
	if (this.player != null) {
		this.lifeUnit.player = player;
		this.magicUnit.magic = player.magic;		
	}
}
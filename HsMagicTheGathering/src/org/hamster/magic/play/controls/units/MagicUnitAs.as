// ActionScript file
import org.hamster.magic.common.events.MagicEvent;
import org.hamster.magic.common.models.Magic;

private var _magic:Magic;

public function set magic(value:Magic):void
{
	if (this.magic != null) {
		this.removeListener(this._magic);
	}
	this._magic = value;
	this.registerListener(this._magic);
	if (this.initialized) {
		magicChangeHandler(null);
	}
}

public function get magic():Magic
{
	return this._magic;
}

private function magicChangeHandler(evt:MagicEvent):void
{
	this.magicRedImage.magicValue = this.magic.red;
	this.magicBlueImage.magicValue = this.magic.blue;
	this.magicGreenImage.magicValue = this.magic.green;
	this.magicBlackImage.magicValue = this.magic.black;
	this.magicWhiteImage.magicValue = this.magic.white;
	this.magicColorlessImage.magicValue = this.magic.colorless;
}

private function registerListener(magic:Magic):void
{
	magic.addEventListener(MagicEvent.CHANGE, magicChangeHandler);
}

private function removeListener(magic:Magic):void
{
	magic.removeEventListener(MagicEvent.CHANGE, magicChangeHandler);
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
}
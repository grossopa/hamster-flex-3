// ActionScript file
import flash.display.Bitmap;
import flash.display.Graphics;

import noorg.magic.events.PlayerEvent;
import noorg.magic.models.Player;
import noorg.magic.models.staticValue.MagicType;
import noorg.magic.utils.Constants;Constants;

private static const ICON_COUNT:int = 10;

private var _player:Player;
[Bindable]
private var _magicCount:int;
private var _magicIcon:Class;

private var _iconBitmap:Bitmap;

public var magicType:uint;

public function set magicIcon(value:Class):void
{
	this._magicIcon = value;
	_iconBitmap = new value();
}

public function get magicIcon():Class
{
	return this._magicIcon;
}

public function get magicCount():int
{
	return _magicCount;
}

public function set player(value:Player):void
{
	if (this._player != null) {
		this._player.removeEventListener(PlayerEvent.MAGIC_CHANGE, magicChangeHandler);
	}
	this._player = value;
	this._player.addEventListener(PlayerEvent.MAGIC_CHANGE, magicChangeHandler);
}

public function get player():Player
{
	return _player;
}

private function completeHandler():void
{
	redraw();
}

private function magicChangeHandler(evt:PlayerEvent):void
{
	if (evt.magicType == this.magicType) {
		_magicCount = evt.magicCount;
		redraw();
	}
}

private function arrowUpClickHandler():void
{
	if (this.magicType == MagicType.BLACK) {
		this.player.magicBlack++;
	} else if (this.magicType == MagicType.BLUE) {
		this.player.magicBlue++;
	} else if (this.magicType == MagicType.COLORLESS) {
		this.player.magicColorless++;
	} else if (this.magicType == MagicType.GREEN) {
		this.player.magicGreen++;
	} else if (this.magicType == MagicType.RED) {
		this.player.magicRed++;
	} else if (this.magicType == MagicType.WHITE) {
		this.player.magicWhite++;
	}
	
}

private function arrowDownClickHandler():void
{
	if (this.magicType == MagicType.BLACK && this.player.magicBlack > 0) {
		this.player.magicBlack--;
	} else if (this.magicType == MagicType.BLUE && this.player.magicBlue > 0) {
		this.player.magicBlue--;
	} else if (this.magicType == MagicType.COLORLESS && this.player.magicColorless > 0) {
		this.player.magicColorless--;
	} else if (this.magicType == MagicType.GREEN && this.player.magicGreen > 0) {
		this.player.magicGreen--;
	} else if (this.magicType == MagicType.RED && this.player.magicRed > 0) {
		this.player.magicRed--;
	} else if (this.magicType == MagicType.WHITE && this.player.magicWhite > 0) {
		this.player.magicWhite--;
	}	
}

private function redraw():void
{
	var g:Graphics = this.graphics;
	g.clear();
	if (_magicCount > 0 && _magicCount <= ICON_COUNT) {
		magicCountLabel.visible = false;
		for (var i:int = 0; i < _magicCount; i++) {
			g.beginBitmapFill(_iconBitmap.bitmapData);
			g.drawRect(i * Constants.MAGIC_ICON_WIDTH, 0, Constants.MAGIC_ICON_WIDTH, Constants.MAGIC_ICON_HEIGHT);
			g.endFill();
		}
	} else {
		magicCountLabel.visible = true;
		g.beginBitmapFill(_iconBitmap.bitmapData);
		g.drawRect(0, 0, Constants.MAGIC_ICON_WIDTH, Constants.MAGIC_ICON_HEIGHT);
		g.endFill();
	}
}
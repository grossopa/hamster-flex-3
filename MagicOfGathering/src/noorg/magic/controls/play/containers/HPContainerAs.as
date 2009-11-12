// ActionScript file
import flash.display.Bitmap;
import flash.events.MouseEvent;

import noorg.magic.events.PlayerEvent;
import noorg.magic.models.Player;
import noorg.magic.services.AssetService;

private static const ICON_WIDTH:int = 15;
private static const ICON_HEIGHT:int = 15;
private static const COLUMN_COUNT:int = 10;
private static const ROW_COUNT:int = 7;
private static const ALL_COUNT:int = 70;

private const AS:AssetService = AssetService.getInstance();

private var _player:Player;

public function set player(value:Player):void
{
	if (this._player != null) {
		this._player.removeEventListener(PlayerEvent.HP_CHANGE, hpChangeHandler);
	}
	this._player = value;
	this._player.addEventListener(PlayerEvent.HP_CHANGE, hpChangeHandler);
	if (this.initialized) {
		redraw();
	}
}

public function get player():Player
{
	return this._player;
}

private var bmHealth:Bitmap;
private var bmDamaged:Bitmap;

private function completeHandler():void
{
	bmHealth = new AS.HPHealth();
	bmDamaged = new AS.HPDamaged();
	
	redraw();
}

private function hpChangeHandler(evt:PlayerEvent):void
{
	redraw();
}

private function clickHandler(evt:MouseEvent):void
{
	var index:int = int(evt.localX / ICON_WIDTH) 
			+ int(evt.localY / ICON_HEIGHT) * COLUMN_COUNT;
	if (index == 0 && this.player.hp == 1) {
		index = -1;
	}
	this.player.hp = index + 1;
}

private function redraw():void
{
	this.graphics.clear();
	
	if (this.player == null) {
		for (var i:int = 0; i < ALL_COUNT; i++) {
			drawPoint(i);
		}
	} else {
		for (var j:int = 0; j < player.hp; j++) {
			drawPoint(j, false);
		}
		for (var k:int = player.hp; k < ALL_COUNT; k++) {
			drawPoint(k);
		}
	}
	
}

private function drawPoint(index:int, isDamaged:Boolean = true):void
{
	var column:int = index % COLUMN_COUNT;
	var row:int = int(index / COLUMN_COUNT);
	
	var drawX:int = column * ICON_WIDTH;
	var drawY:int = row * ICON_HEIGHT;
	
	this.graphics.beginBitmapFill(isDamaged == true ? bmDamaged.bitmapData : bmHealth.bitmapData);
	this.graphics.drawRect(drawX, drawY, ICON_WIDTH, ICON_HEIGHT);
	this.graphics.endFill();
}
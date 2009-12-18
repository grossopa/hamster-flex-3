// ActionScript file
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;

import noorg.magic.models.MagicPool;
import noorg.magic.models.PlayCard;
import noorg.magic.models.Player;
import noorg.magic.services.AssetService;
import noorg.magic.utils.GlobalUtil;

public static const AS:AssetService = AssetService.getInstance();
public static const BITMAP_CLASSES:Array = [
												AS.IconMagicPointWhite_30,
												AS.IconMagicPointBlue_30,
												AS.IconMagicPointBlack_30,
												AS.IconMagicPointRed_30,
												AS.IconMagicPointGreen_30,
												AS.IconMagicPointColorless_30
											];

private var _player:Player;

private var _requiredColorlessCount:int;
private var _requiredColorlessArray:ArrayCollection = new ArrayCollection();
private var _playerMagicPool:MagicPool = new MagicPool();


public function setPlayer(value:Player, card:PlayCard):void
{
	this._player = value;
	_requiredColorlessArray = new ArrayCollection();
	_playerMagicPool.white = _player.magicWhite - card.magicPool.white;
	_playerMagicPool.blue = _player.magicBlue - card.magicPool.blue;
	_playerMagicPool.black = _player.magicBlack - card.magicPool.black;
	_playerMagicPool.red = _player.magicRed - card.magicPool.red;
	_playerMagicPool.green = _player.magicGreen - card.magicPool.green;
	_playerMagicPool.colorless = 0;
}

public function get player():Player
{
	return this._player;
}

private function requiredClickHandler(evt:MouseEvent):void
{
	var index:int = evt.localX % 30;
	if (index > _requiredColorlessArray.length) {
		return;
	} else {
		var colorIndex:int = int(_requiredColorlessArray[index]);
		_requiredColorlessArray.removeItemAt(index);
		switch (colorIndex) {
			case 0:
			{
				this._playerMagicPool.white += 1;
				break;
			}
			case 1:
			{
				this._playerMagicPool.blue += 1;
				break;
			}
			case 2:
			{
				this._playerMagicPool.black += 1;
				break;
			}
			case 3:
			{
				this._playerMagicPool.red += 1;
				break;
			}
			case 4:
			{
				this._playerMagicPool.green += 1;
				break;
			}
			case 5:
			{
				this._playerMagicPool.colorless += 1;
				break;
			}
		}
	}
	
	this.invalidateDisplayList();
}

private function playerClickHandler(evt:MouseEvent):void
{
	var index:int = evt.localX % 30;
	_requiredColorlessArray.removeItemAt(index);
	switch (index) {
		case 0:
		{
			if (this._playerMagicPool.white > 0) {
				this._playerMagicPool.white -= 1;
				this._requiredColorlessArray.addItem(0);
			}
			break;
		}
		case 1:
		{
			if (this._playerMagicPool.blue > 0) {
				this._playerMagicPool.blue -= 1;
				this._requiredColorlessArray.addItem(1);
			}
			break;
		}
		case 2:
		{
			if (this._playerMagicPool.black > 0) {
				this._playerMagicPool.black -= 1;
				this._requiredColorlessArray.addItem(2);
			}
			break;
		}
		case 3:
		{
			if (this._playerMagicPool.red > 0) {
				this._playerMagicPool.red -= 1;
				this._requiredColorlessArray.addItem(3);
			}
			break;
		}
		case 4:
		{
			if (this._playerMagicPool.green > 0) {
				this._playerMagicPool.green -= 1;
				this._requiredColorlessArray.addItem(4);
			}
			break;
		}
		case 5:
		{
			if (this._playerMagicPool.colorless > 0) {
				this._playerMagicPool.colorless -= 1;
				this._requiredColorlessArray.addItem(5);
			}
			break;
		}
	}
	
	if (this.player.magicColorless == this._requiredColorlessArray.length + 1) {
		// take effect
		this.player.magicBlack = this._playerMagicPool.black;
		this.player.magicBlue = this._playerMagicPool.blue;
		this.player.magicColorless = this._playerMagicPool.colorless;
		this.player.magicGreen = this._playerMagicPool.green;
		this.player.magicRed = this._playerMagicPool.red;
		this.player.magicWhite = this._playerMagicPool.white;
		GlobalUtil.removePopup(this);
	}
	this.invalidateDisplayList();
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	var rg:Graphics = this.requiredPayContainer.graphics;
	rg.clear();
	
	for (var i:int = 0; i < this._requiredColorlessArray.length; i++) {
		var index:int = int(_requiredColorlessArray[i]);
		var bitmapData:BitmapData = new BITMAP_CLASSES[index]();
		rg.beginBitmapFill(bitmapData);
		rg.drawRect(i * bitmapData.width, y, bitmapData.width, bitmapData.height);
		rg.endFill();
	}
	
	var pg:Graphics = this.playerMagicContainer.graphics;
	pg.clear();
	drawMagicGraphic(pg, AS.IconMagicPointWhite_30, 	0,   _playerMagicPool.white);
	drawMagicGraphic(pg, AS.IconMagicPointBlue_30, 		30,  _playerMagicPool.blue);
	drawMagicGraphic(pg, AS.IconMagicPointBlack_30, 	60,  _playerMagicPool.black);
	drawMagicGraphic(pg, AS.IconMagicPointRed_30, 		90,  _playerMagicPool.red);
	drawMagicGraphic(pg, AS.IconMagicPointGreen_30, 	120, _playerMagicPool.green);
	drawMagicGraphic(pg, AS.IconMagicPointColorless_30, 150, _playerMagicPool.colorless);
}

private function drawMagicGraphic(g:Graphics, className:Class, y:int, count:int):void
{
	if (count == 0) {
		return;
	}
	var bitmapData:BitmapData = new className();
	g.beginBitmapFill(bitmapData);
	g.drawRect(0, y, bitmapData.width * count, bitmapData.height);
	g.endFill();
}

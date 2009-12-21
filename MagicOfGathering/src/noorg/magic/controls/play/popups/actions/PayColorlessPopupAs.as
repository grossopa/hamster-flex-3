// ActionScript file
import flash.display.Bitmap;
import flash.display.Graphics;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;

import noorg.magic.models.MagicPool;
import noorg.magic.models.PlayCard;
import noorg.magic.models.Player;
import noorg.magic.models.actions.base.ICardAction;
import noorg.magic.services.AssetService;
import noorg.magic.utils.Constants;
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
private var _playCard:PlayCard;
private var _action:ICardAction;

private var _requiredColorlessCount:int;
private var _requiredColorlessArray:ArrayCollection = new ArrayCollection();
private var _playerMagicPool:MagicPool = new MagicPool();


public function setPlayer(value:Player, card:PlayCard, action:ICardAction = null):void
{
	this._player = value;
	this._playCard = card;
	this._action = action;
	
	_requiredColorlessArray = new ArrayCollection();
	_playerMagicPool.white = _player.magicWhite - card.magicPool.white;
	_playerMagicPool.blue = _player.magicBlue - card.magicPool.blue;
	_playerMagicPool.black = _player.magicBlack - card.magicPool.black;
	_playerMagicPool.red = _player.magicRed - card.magicPool.red;
	_playerMagicPool.green = _player.magicGreen - card.magicPool.green;
	_playerMagicPool.colorless = 0;
	
	this.invalidateDisplayList();
}

public function get player():Player
{
	return this._player;
}

private function requiredClickHandler(evt:MouseEvent):void
{
	var index:int = int(evt.localX / 30);
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
	var index:int = int(evt.localY / 30);
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
	
	if (this._playCard.magicPool.colorless == this._requiredColorlessArray.length) {
		// take effect
		this.player.magicBlack = this._playerMagicPool.black;
		this.player.magicBlue = this._playerMagicPool.blue;
		this.player.magicColorless = this._playerMagicPool.colorless;
		this.player.magicGreen = this._playerMagicPool.green;
		this.player.magicRed = this._playerMagicPool.red;
		this.player.magicWhite = this._playerMagicPool.white;
		
		// action is null, then directly do cast
		if (_action == null) {
			this._playCard.cast(true);
		} else {
			// _action.execute()
		}
		
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
		var bitmap:Bitmap = new BITMAP_CLASSES[index]();
		rg.beginBitmapFill(bitmap.bitmapData);
		rg.drawRect(i * bitmap.width, 0, bitmap.width, bitmap.height);
		rg.endFill();
	}
	
	var pg:Graphics = this.playerMagicContainer.graphics;
	pg.clear();
	drawMagicGraphic(pg, AS.IconMagicPointWhite_30, 	0,   
			_playerMagicPool.white, 	Constants.WHITE_COLOR);
	drawMagicGraphic(pg, AS.IconMagicPointBlue_30, 		30,  
			_playerMagicPool.blue, 		Constants.BLUE_COLOR);
	drawMagicGraphic(pg, AS.IconMagicPointBlack_30, 	60, 
			 _playerMagicPool.black, 	Constants.BLACK_COLOR);
	drawMagicGraphic(pg, AS.IconMagicPointRed_30, 		90,  
			_playerMagicPool.red, 		Constants.RED_COLOR);
	drawMagicGraphic(pg, AS.IconMagicPointGreen_30, 	120, 
			_playerMagicPool.green, 	Constants.GREEN_COLOR);
	drawMagicGraphic(pg, AS.IconMagicPointColorless_30, 150, 
			_playerMagicPool.colorless, Constants.COLORLESS_COLOR);
}

private function drawMagicGraphic(g:Graphics, className:Class, y:int, 
		count:int, bgColor:int):void
{
	if (count == 0) {
		return;
	}
	
	g.beginFill(bgColor, 0.3);
	g.drawRect(0, y, this.width, 30);
	g.endFill();
	
	var bitmap:Bitmap = new className();
	g.beginBitmapFill(bitmap.bitmapData);
	g.drawRect(0, y, bitmap.width * count, bitmap.height);
	g.endFill();
	

}

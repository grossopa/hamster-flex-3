// ActionScript file
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.geom.Point;

import noorg.magic.models.MagicPool;
import noorg.magic.services.AssetService;
import noorg.magic.utils.Constants;

public static const AS:AssetService = AssetService.getInstance();

[Bindable]
public var redValue:int;
[Bindable]
public var greenValue:int;
[Bindable]
public var blueValue:int;
[Bindable]
public var whiteValue:int;
[Bindable]
public var blackValue:int;
[Bindable]
public var colorlessValue:int;

private var _magicPool:MagicPool;

public function set magicPool(value:MagicPool):void
{
	_magicPool = value;
	
	this.redValue = value.red;
	this.greenValue = value.green;
	this.blueValue = value.blue;
	this.whiteValue = value.white;
	this.blackValue = value.black;
	this.colorlessValue = value.colorless;
}

public function get magicPool():MagicPool
{
	return _magicPool;
}

public function clickHandler(type:String, value:int):void
{
	switch (type) {
		case Constants.RED:
		{
			this.redValue += value;
			break;
		}
		case Constants.GREEN:
		{
			this.greenValue += value;
			break;
		}
		case Constants.BLUE:
		{
			this.blueValue += value;
			break;
		}
		case Constants.WHITE:
		{
			this.whiteValue += value;
			break;
		}
		case Constants.BLACK:
		{
			this.blackValue += value;
			break;
		}
		case Constants.COLORLESS:
		{
			this.colorlessValue += value;
			break;
		}
	}
}

public function validateMagicPool():MagicPool
{
	if (_magicPool == null) {
		_magicPool = new MagicPool();
	}
	
	_magicPool.black = this.blackValue;
	_magicPool.blue = this.blueValue;
	_magicPool.green = this.greenValue;
	_magicPool.red = this.redValue;
	_magicPool.white = this.whiteValue;
	_magicPool.colorless = this.colorlessValue;
	
	return _magicPool;
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	var g:Graphics = this.graphics;
	
	var bdDraw:BitmapData = new BitmapData(uw, uh, true, 0x00);
	var bdRed:Bitmap = new AS.IconMagicPointRed();
	bdDraw.copyPixels(bdRed.bitmapData, bdRed.bitmapData.rect, new Point());
	var bdGreen:Bitmap = new AS.IconMagicPointGreen();
	bdDraw.copyPixels(bdGreen.bitmapData, bdGreen.bitmapData.rect, new Point(15, 0));
	var bdBlue:Bitmap = new AS.IconMagicPointBlue();
	bdDraw.copyPixels(bdBlue.bitmapData, bdBlue.bitmapData.rect, new Point(30, 0));
	var bdWhite:Bitmap = new AS.IconMagicPointWhite();
	bdDraw.copyPixels(bdWhite.bitmapData, bdWhite.bitmapData.rect, new Point(45, 0));
	var bdBlack:Bitmap = new AS.IconMagicPointBlack();
	bdDraw.copyPixels(bdBlack.bitmapData, bdBlack.bitmapData.rect, new Point(60, 0));
	var bdColorless:Bitmap = new AS.IconMagicPointColorless();
	bdDraw.copyPixels(bdColorless.bitmapData, bdColorless.bitmapData.rect, new Point(75, 0));
	g.clear();
	g.beginBitmapFill(bdDraw);
	g.drawRect(0, 0, uw, uh);
	g.endFill();
}
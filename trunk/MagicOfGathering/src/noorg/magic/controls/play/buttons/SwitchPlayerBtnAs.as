// ActionScript file
import flash.display.Bitmap;
import flash.display.Graphics;
import flash.geom.Matrix;

import mx.effects.Fade;

import noorg.magic.services.AssetService;

private static const AS:AssetService = AssetService.getInstance();
private static const FADE_DURATION:int = 250;

private const fade:Fade = new Fade();

private var _isUpArrow:Boolean = true;

public function set isUpArrow(value:Boolean):void
{
	this._isUpArrow = value;
	if (this.initialized) {
		this.redraw();
	}
}

public function get isUpArrow():Boolean
{
	return this._isUpArrow;
}

private function completeHandler():void
{
	fade.target = this;
	
	this.redraw();
}

private function rollOverHandler():void
{
	fade.stop();
	fade.alphaFrom = this.alpha;
	fade.alphaTo = 1;
	fade.duration = (1 - this.alpha) * FADE_DURATION;
	fade.play();
}

private function rollOutHandler():void
{
	fade.stop();
	fade.alphaFrom = this.alpha;
	fade.alphaTo = 0.01;
	fade.duration = this.alpha * FADE_DURATION;
	fade.play();	
}

private function redraw():void
{
	var bm:Bitmap = new AS.BtnSwitchPlayer();
	
	var m:Matrix;
	
	if (!isUpArrow) {
		m = new Matrix();
		m.rotate(Math.PI);
	}
	
	var g:Graphics = this.mainButton.graphics;
	g.clear();
	g.beginBitmapFill(bm.bitmapData, m);
	g.drawRect(0, 0, this.mainButton.width, this.mainButton.height);
	g.endFill();
}
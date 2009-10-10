// ActionScript file
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.filesystem.File;

import mx.effects.Fade;
import mx.effects.Move;

import noorg.events.SelFileEvent;
import noorg.models.album.ImageData;

private static const DURATION:Number = 750;
private static const ICON_LIST_DURATION:Number = 500;

[Bindable]
public var file:File;
[Bindable]
public var index:int;
public var startDelay:int;
public var imageData:ImageData;

private var _iconListMove:Move = new Move();

private function completeHandler():void
{
	initImage();
	fadeInEffect();
	file.addEventListener(Event.COMPLETE, loadCompleteHandler);
	
	_iconListMove.target = iconList;
	_iconListMove.duration = ICON_LIST_DURATION;
	
	iconList.y = this.height;
}

private function initImage():void
{
	if (this.file != null && this.file.data != null && this.file.data.length != 0) {
		// TODO: fix not real image file issue
		this.mainImage.source = this.file.data;
	} else {
		// error handler
		ioErrorHandler();
	}
}

private function fadeInEffect():void
{
	var fade:Fade = new Fade(this);
	fade.alphaFrom = 0;
	fade.alphaTo = 1;
	fade.duration = DURATION;
	fade.startDelay = DURATION / 2 * this.startDelay;
	fade.play();
}

private function reloadImg():void
{
	file.load();
}

private function deleteImg():void
{
	this.dispatchEvent(new SelFileEvent(SelFileEvent.DELETE_IMG));
}

private function loadCompleteHandler(evt:Event):void
{
	this.mainImage.source = this.file.data;
}

private function ioErrorHandler(evt:IOErrorEvent = null):void
{
	this.mainImage.visible = false;
	this.setStyle("backgroundColor", 0xFFFFFF);
	this.setStyle("backgroundAlpha", 1);
}

private function rollOverHandler():void
{
	_iconListMove.stop();
	_iconListMove.yTo = this.height - 24;
	_iconListMove.play();
}

private function rollOutHandler():void
{
	_iconListMove.stop();
	_iconListMove.yTo = this.height;
	_iconListMove.play();	
}
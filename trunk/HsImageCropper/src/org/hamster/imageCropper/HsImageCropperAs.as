// ActionScript file
import flash.display.Graphics;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import mx.core.Application;
import mx.managers.CursorManager;

private static const TOP:uint 		= 0x00001;
private static const LEFT:uint 		= 0x00010;
private static const BOTTOM:uint 	= 0x00100;
private static const RIGHT:uint 	= 0x01000;
private static const MOVE:uint		= 0x10000;

[Embed(source='/org/hamster/imageCropper/assets/resize_move.png')]
private var _cursor_move:Class;
[Embed(source='/org/hamster/imageCropper/assets/resize_horizontal.png')]
private var _cursor_h:Class;
[Embed(source='/org/hamster/imageCropper/assets/resize_hv_left.png')]
private var _cursor_hvl:Class;
[Embed(source='/org/hamster/imageCropper/assets/resize_hv_right.png')]
private var _cursor_hvr:Class;
[Embed(source='/org/hamster/imageCropper/assets/resize_vertical.png')]
private var _cursor_v:Class;

private var _imgWidth:Number;
private var _imgHeight:Number;

private var _originX:Number			= 0;
private var _originY:Number			= 0;
private var _originWidth:Number		= 0;
private var _originHeight:Number	= 0;

private var _cropX:Number			= 0;
private var _cropY:Number			= 0;
private var _cropWidth:Number		= 0;
private var _cropHeight:Number		= 0;

private var _offsetX:Number			= 0;
private var _offsetY:Number			= 0;

private var _isLeftEnabled:Boolean;
private var _isRightEnabled:Boolean;
private var _isTopEnabled:Boolean;
private var _isBottomEnabled:Boolean;
private var _isMoveEnabled:Boolean;

[Bindable]
private var _mainImgX:Number;
[Bindable]
private var _mainImgY:Number;
[Bindable]
private var _mainImgWidth:Number;
[Bindable]
private var _mainImgHeight:Number;
[Bindable]
private var _source:Object;

private var _selMinX:Number = 0;
private var _selMinY:Number = 0;
private var _selMinWidth:Number = 20;
private var _selMinHeight:Number = 20;

private var _selMaxX:Number;
private var _selMaxY:Number;
private var _selMaxWidth:Number;
private var _selMaxHeight:Number;

/**
 * styles
 */
public var maskColor:uint = 0x000000;
public var maskColorAlpha:Number = 0.4;
[Bindable]
private var _unitSize:int = 10;
private var _dotLineColor:uint = 0xffffff;
private var _dotLineAlpha:Number = 0.6;
private var _dotLineLength:int = 5;
private var _dotLineGap:int = 5;

private var _padding:Number = 5;

/**
 * array [x, y, width, height];
 */
public function getCropArea():Rectangle
{
	var r:Number = this._imgWidth / _mainImgWidth;
	return new Rectangle(
			(this.selAreaCanvas.x - _mainImgX) * r, 
			(selAreaCanvas.y - _mainImgY) * r, 
			selAreaCanvas.width * r, 
			selAreaCanvas.height * r);
}

public function get paddingWidth():Number
{
	return Math.max(this.width - _padding * 2, 0);
}

public function get paddingHeight():Number
{
	return Math.max(this.height - _padding * 2, 0);
}

public function setImageData(src:Object, w:Number, h:Number):void
{
	_source = src;
	_imgWidth = w;
	_imgHeight = h;
	
	var thisRatio:Number = Number(this.paddingWidth / this.paddingHeight);
	var imgRatio:Number = Number(w / h);
	
	if (imgRatio >= thisRatio) {
		_mainImgWidth 	= this.paddingWidth;
		_mainImgHeight 	= this.paddingWidth / imgRatio;
		_mainImgX 		= _padding;
		_mainImgY 		= (this.paddingHeight - _mainImgHeight) / 2;
	} else {
		_mainImgHeight 	= this.paddingHeight;
		_mainImgWidth 	= this.paddingHeight * imgRatio;
		_mainImgY 		= _padding;
		_mainImgX 		= (this.width - _mainImgWidth) / 2;		
	}
	
	_selMinX			= _mainImgX;
	_selMinY			= _mainImgY;
	_selMaxX 			= _mainImgX + _mainImgWidth;
	_selMaxY 			= _mainImgY + _mainImgHeight;
	_selMaxWidth 		= _mainImgWidth;
	_selMaxHeight 		= _mainImgHeight;
	
	this.selAreaCanvas.x 		= _selMaxX - _selMaxWidth * 0.75;
	this.selAreaCanvas.y 		= _selMaxY - _selMaxHeight * 0.75;
	this.selAreaCanvas.width 	= _selMaxWidth / 2;
	this.selAreaCanvas.height 	= _selMaxHeight / 2;
	
	drawMask();
	
}

private function completeHandler():void
{
	Application.application.addEventListener(MouseEvent.MOUSE_UP, 
			stageMouseUpHandler, false, 0, true);
}

private function maskMouseUpHandler(evt:MouseEvent):void
{
	_isTopEnabled 		= false;
	_isLeftEnabled 		= false;
	_isRightEnabled 	= false;
	_isBottomEnabled 	= false;
	_isMoveEnabled		= false;
	removeCursor();
}

private function imageCropperUnitRollOverHandler(evt:MouseEvent, modes:uint):void
{
	if (!evt.buttonDown) {
		changeCursor(modes);
	}
}

private function imageCropperUnitRollOutHandler(evt:MouseEvent, modes:uint):void
{
	if (!evt.buttonDown) {
		this.removeCursor();
	}
}

private function stageMouseUpHandler(evt:MouseEvent):void
{
	this.removeCursor();
}


private function imageCropperUnitDownHandler(evt:MouseEvent, modes:uint):void
{
	_offsetX 		= selAreaCanvas.x;
	_offsetY 		= selAreaCanvas.y;	

	_originX 		= evt.stageX;
	_originY 		= evt.stageY;
	_originWidth 	= selAreaCanvas.width;
	_originHeight 	= selAreaCanvas.height;
	
	_cropX 			= _originX;
	_cropY 			= _originY;
	_cropWidth 		= _originWidth;
	_cropHeight 	= _originHeight;
	
	_isTopEnabled 		= (TOP    & modes) 	!= 0;
	_isLeftEnabled 		= (LEFT   & modes) 	!= 0;
	_isBottomEnabled 	= (BOTTOM & modes) 	!= 0;
	_isRightEnabled 	= (RIGHT  & modes) 	!= 0;
	_isMoveEnabled		= (MOVE	  & modes)  != 0;
	
	changeCursor(modes);
}

private function changeCursor(modes:uint):void
{
	var top:Boolean 	= (TOP    & modes) != 0;
	var left:Boolean 	= (LEFT   & modes) != 0;
	var bottom:Boolean 	= (BOTTOM & modes) != 0;
	var right:Boolean 	= (RIGHT  & modes) != 0;
	var move:Boolean	= (MOVE	  & modes) != 0;

	var cursor:Class;
	if ((top && left) || (right && bottom)) {
		cursor = _cursor_hvl;
	} else if ((top && right) || (left && bottom)) {
		cursor = _cursor_hvr;
	} else if (top || bottom) {
		cursor = _cursor_v;
	} else if (left || right) {
		cursor = _cursor_h;
	} else if (move) {
		cursor = _cursor_move;
	} else {
		return;
	}
	CursorManager.setCursor(cursor, 2, -13, -13);
}

private function removeCursor():void
{
	CursorManager.removeAllCursors();
}

private function maskMouseMoveHandler(evt:MouseEvent):void
{
	if (!evt.buttonDown) {
		return;
	}
	
	var deltaX:Number = evt.stageX - _originX;
	var deltaY:Number = evt.stageY - _originY;
	
	if (_isRightEnabled) {
		_cropWidth = _originWidth + deltaX;
		validateCropWidth();
	}
	
	if (_isBottomEnabled) {
		_cropHeight = _originHeight + deltaY;
		validateCropHeight();
	}
	
	if (_isTopEnabled) {
		_cropY = _offsetY + deltaY;
		_cropHeight = _originHeight - deltaY + Math.min(_cropY - _selMinY, 0);
		validateCropY();
		validateCropHeight();
	}
	
	if (_isLeftEnabled) {
		_cropX = _offsetX + deltaX;
		_cropWidth = _originWidth - deltaX + Math.min(_cropX - _selMinX, 0);
		validateCropX();
		validateCropWidth();
	}
	
	if (_isMoveEnabled) {
		_cropX = _offsetX + deltaX;
		_cropY = _offsetY + deltaY;
		validateCropX();
		validateCropY();
	}
	
	drawMask();
}

private function validateCropX():void
{
	if (_cropX < _selMinX) {
		_cropX = _selMinX;
	} else if (_cropX + _cropWidth > _selMaxX) {
		_cropX = _selMaxX - _cropWidth;
	} else if (_cropWidth <= _selMinWidth) {
		_cropX = _offsetX + _originWidth - _selMinWidth;
	}
	selAreaCanvas.x = _cropX;
}

private function validateCropY():void
{
	if (_cropY < _selMinY) {
		_cropY = _selMinY;
	} else if (_cropY + _cropHeight > _selMaxY) {
		_cropY = _selMaxY - _cropHeight;
	} else if (_cropHeight <= _selMinHeight) {
		_cropY = _offsetY + _originHeight - _selMinHeight;
	}
	selAreaCanvas.y = _cropY;
}

private function validateCropWidth():void
{
	if (_cropWidth < _selMinWidth) {
		_cropWidth = _selMinWidth;
	} else if (selAreaCanvas.x + _cropWidth > _selMaxX) {
		_cropWidth = _selMaxX - selAreaCanvas.x;
	}
	selAreaCanvas.width = _cropWidth;
}

private function validateCropHeight():void
{
	if (_cropHeight < _selMinHeight) {
		_cropHeight = _selMinHeight;
	} else if (selAreaCanvas.y + _cropHeight > _selMaxY) {
		_cropHeight = _selMaxY - selAreaCanvas.y;
	}
	selAreaCanvas.height = _cropHeight;
}

private function drawMask():void
{
	var g:Graphics = maskImage.graphics;
	g.clear();
	g.beginFill(maskColor, maskColorAlpha);
	g.lineStyle(1, maskColor, 0);
	g.moveTo(0, 0);
	g.lineTo(maskImage.width, 0);
	g.lineTo(maskImage.width, maskImage.height);
	g.lineTo(0, maskImage.height);
	g.lineTo(0, 0);
	g.moveTo(selAreaCanvas.x, selAreaCanvas.y);
	g.lineTo(selAreaCanvas.x + selAreaCanvas.width, selAreaCanvas.y);
	g.lineTo(selAreaCanvas.x + selAreaCanvas.width, selAreaCanvas.y + selAreaCanvas.height);
	g.lineTo(selAreaCanvas.x, selAreaCanvas.y + selAreaCanvas.height);
	g.lineTo(selAreaCanvas.x, selAreaCanvas.y);
	g.endFill();
	
	var og:Graphics = selAreaCanvas.graphics;
	og.clear();
	og.lineStyle(1, _dotLineColor, _dotLineAlpha);
	
	var padding:int = 0;
	var padBottom:int = selAreaCanvas.height - padding;
	var padRight:int = selAreaCanvas.width - padding;
	
	var padRightPadding:int = padRight - _dotLineLength - _dotLineGap;
	var padBottomPadding:int = padBottom - _dotLineLength - _dotLineGap;
	
	og.moveTo(padding, padding);
	var curWidth:Number = 0;
	while (curWidth <= padRightPadding) {
		og.lineTo(curWidth + _dotLineLength, padding);
		curWidth += _dotLineLength + _dotLineGap;
		og.moveTo(curWidth, padding);
	}
	if (curWidth <= padRight) {
		og.lineTo(padRight, padding);
	}
	
	og.moveTo(padding, padBottom);
	curWidth = 0;
	while (curWidth <= padRightPadding) {
		og.lineTo(curWidth + _dotLineLength, padBottom);
		curWidth += _dotLineLength + _dotLineGap;
		og.moveTo(curWidth, padBottom);
	}
	if (curWidth <= padRight) {
		og.lineTo(padRight, padBottom);
	}
	
	og.moveTo(padding, padding);
	var curHeight:Number = 0;
	while (curHeight <= padBottomPadding) {
		og.lineTo(padding, curHeight + _dotLineLength);
		curHeight += _dotLineLength + _dotLineGap;
		og.moveTo(padding, curHeight);
	}
	if (curHeight <= padBottom) {
		og.lineTo(padding, padBottom);
	}
	
	
	og.moveTo(padRight, padding);
	curHeight = 0;
	while (curHeight <= padBottomPadding) {
		og.lineTo(padRight, curHeight + _dotLineLength);
		curHeight += _dotLineLength + _dotLineGap;
		og.moveTo(padRight, curHeight);
	}
	if (curHeight <= padBottom) {
		og.lineTo(padRight, padBottom);
	}
	
}
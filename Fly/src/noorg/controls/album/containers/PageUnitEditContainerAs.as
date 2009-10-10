// ActionScript file
import mx.core.UIComponent;
import mx.events.DragEvent;
import mx.managers.DragManager;

import noorg.controls.album.units.ImageUnit;
import noorg.controls.album.units.PageUnit;
import noorg.controls.management.units.SelImageUnit;

private var originX:Number;
private var originY:Number;
private var originWidth:Number;
private var originHeight:Number;

private var largeX:Number;
private var largeY:Number;
private var largeWidth:Number;
private var largeHeight:Number;

private var padding:Number = 10;

public function showPageUnit(pageUnit:PageUnit, animation:Boolean = true):void
{
	originX = pageUnit.x;
	originY = pageUnit.y;
	originWidth = pageUnit.width;
	originHeight = pageUnit.height;
	
	var containerRatio:Number = this.width / this.height;
	var pageUnitRatio:Number = pageUnit.ratio;
	
	if (containerRatio > pageUnitRatio) {
		largeY = padding;
		largeHeight = this.height - padding * 2;
		largeWidth = largeHeight * pageUnit.ratio;
		largeX = this.width - largeWidth >> 1;
	} else {
		largeX = padding;
		largeWidth = this.width - padding * 2;
		largeHeight = largeWidth / pageUnit.ratio;
		largeY = this.height - largeHeight >> 1;		
	}
	
	pageUnit.x = largeX;
	pageUnit.y = largeY;
	pageUnit.width = largeWidth;
	pageUnit.height = largeHeight;
	
	pageUnit.validatePageStyle();
	
	this.addPageUnit(pageUnit);
	
}

public function animate():void
{
	
}

private function addPageUnit(pageUnit:PageUnit):void
{
	this.addChild(pageUnit);
	this.addPageUnitListener(pageUnit);
}

private function removePageUnit(pageUnit:PageUnit):void
{
	this.removeChild(pageUnit);
	this.removePageUnitListener(pageUnit);
}

private function addPageUnitListener(pageUnit:PageUnit):void
{
	for each (var imgUnit:ImageUnit in pageUnit.imageUnitContainer.getChildren()) {
		imgUnit.addEventListener(DragEvent.DRAG_ENTER, imgUnitDragEnterHandler);
		imgUnit.addEventListener(DragEvent.DRAG_DROP, imgUnitDragDropHandler);
	}
}

private function removePageUnitListener(pageUnit:PageUnit):void
{
	for each (var imgUnit:ImageUnit in pageUnit.imageUnitContainer.getChildren()) {
		imgUnit.removeEventListener(DragEvent.DRAG_ENTER, imgUnitDragEnterHandler);
		imgUnit.removeEventListener(DragEvent.DRAG_DROP, imgUnitDragDropHandler);
	}	
}

//////////////////////////////
// ImageUnit Event Listener //
//////////////////////////////
private function isImgUnitDragDropAllowed(evt:DragEvent):Boolean
{
	if (evt.dragInitiator is SelImageUnit) {
		return true;
	} else {
		return false;
	}
}

private function imgUnitDragEnterHandler(evt:DragEvent):void
{
	if (this.isImgUnitDragDropAllowed(evt)) {
		DragManager.acceptDragDrop(UIComponent(evt.currentTarget));
	}
}

private function imgUnitDragDropHandler(evt:DragEvent):void
{
	var curImgUnit:ImageUnit = ImageUnit(evt.currentTarget);
	if (evt.dragInitiator is SelImageUnit) {
		var selImgUnit:SelImageUnit = SelImageUnit(evt.dragInitiator);
		curImgUnit.imageData = selImgUnit.imageData;
	}
}
// ActionScript file
import flash.events.MouseEvent;

import mx.core.DragSource;
import mx.core.UIComponent;
import mx.managers.DragManager;

import noorg.controls.management.units.SelBgImgUnit;
import noorg.events.InitDataEvent;
import noorg.models.album.BackgroundImage;
import noorg.services.DataService;
import noorg.services.EventService;
import noorg.utils.factories.ItemFactory;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private function completeHandler():void
{
	ES.addEventListener(InitDataEvent.INIT_DATA_COMPLETE, initBgImgHandler);
}

private function initBgImgHandler(evt:InitDataEvent):void
{
	for each (var bgImg:BackgroundImage in DS.bgImgs) {
		this.addBgImgUnit(ItemFactory.createSelBgImgUnit(bgImg));
	}
}

private function addBgImgUnit(bgImgUnit:SelBgImgUnit):void
{
	this.mainContainer.addPageUnit(bgImgUnit);
	this.addBgImgUnitListener(bgImgUnit);
}

private function removeBgImgUnit(bgImgUnit:SelBgImgUnit):void
{
	this.mainContainer.removePageUnit(bgImgUnit);
	this.addBgImgUnitListener(bgImgUnit);
}

private function addBgImgUnitListener(bgImgUnit:SelBgImgUnit):void
{
	bgImgUnit.addEventListener(MouseEvent.MOUSE_DOWN, bgImgUnitMouseDownHandler);
//	bgImgUnit.addEventListener(MouseEvent.MOUSE_MOVE, bgImgUnitMouseMoveHandler);
}

private function removeBgImgUnitListener(bgImgUnit:SelBgImgUnit):void
{
	bgImgUnit.removeEventListener(MouseEvent.MOUSE_DOWN, bgImgUnitMouseDownHandler);
//	bgImgUnit.removeEventListener(MouseEvent.MOUSE_MOVE, bgImgUnitMouseMoveHandler);	
}

private function bgImgUnitMouseDownHandler(evt:MouseEvent):void
{
	if (evt.buttonDown && !DragManager.isDragging) {
		var ds:DragSource = new DragSource();
		ds.addData({"x":evt.localX, "y":evt.localY}, "xy");
		DragManager.doDrag(UIComponent(evt.currentTarget), ds, evt);
	}
}

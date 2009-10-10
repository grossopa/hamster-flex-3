// ActionScript file
import mx.events.DragEvent;
import mx.managers.DragManager;

import noorg.controls.album.units.PageUnit;
import noorg.controls.management.units.SelBgImgUnit;
import noorg.models.album.PageStyle;

private function completeHandler():void
{
	
}

public function addPageByStyle(pageStyle:PageStyle = null):PageUnit
{
	var pageUnit:PageUnit = this.mainContainer.addPageByStyle(pageStyle);
	this.addPageUnitListener(pageUnit);
	return pageUnit;
}

///////////////////////////
// reg & unreg listeners //
///////////////////////////
private function addPageUnitListener(pageUnit:PageUnit):void
{
	pageUnit.addEventListener(DragEvent.DRAG_ENTER, pageUnitDragEnterHandler);
	pageUnit.addEventListener(DragEvent.DRAG_DROP, pageUnitDragDropHandler);
}

private function removePageUnitListener(pageUnit:PageUnit):void
{
	pageUnit.removeEventListener(DragEvent.DRAG_ENTER, pageUnitDragEnterHandler);
	pageUnit.removeEventListener(DragEvent.DRAG_DROP, pageUnitDragDropHandler);
}

public function showPageUnit(pageUnit:PageUnit):void
{
	// this.editContainer.showPageUnit(pageUnit, false);
}

public function get selectedPageUnit():PageUnit
{
	return this.mainContainer.selectedPageUnit;
}

///////////////////////////////
// page unit event listeners //
///////////////////////////////
private function pageUnitDragEnterHandler(evt:DragEvent):void
{
	var pageUnit:PageUnit = PageUnit(evt.currentTarget);
	if (evt.dragInitiator is PageUnit) {
		DragManager.acceptDragDrop(pageUnit);
	}
}

private function pageUnitDragDropHandler(evt:DragEvent):void
{
	var pageUnit:PageUnit = PageUnit(evt.currentTarget);
	if (evt.dragInitiator is SelBgImgUnit) {
		var selBgImgUnit:SelBgImgUnit = SelBgImgUnit(evt.dragInitiator);
		pageUnit.pageStyle.bgImg = selBgImgUnit.bgImg.clone();
		pageUnit.validateBgImg();
	}
}
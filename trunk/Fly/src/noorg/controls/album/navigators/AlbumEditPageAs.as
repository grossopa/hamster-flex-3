// ActionScript file
import flash.events.MouseEvent;

import noorg.controls.album.units.PageUnit;
import noorg.controls.management.units.SelBgImgUnit;
import noorg.events.PageUnitEvent;
import noorg.models.album.PageStyle;
import noorg.services.DataService;

private static const DS:DataService = DataService.getInstance();

///////////////////////
// handler functions //
///////////////////////
private function completeHandler():void
{
	selBgImgContainer.addEventListener(PageUnitEvent.SELECT_PAGEUNIT, bgImgSelectedHandler);
}

private function addPageHandler():void
{
	this.addPageUnit(DS.defaultPageStyle);
}

private function rollOverHandler():void
{
	
}

private function rollOutHandler():void
{
	
}

/////////////////////////////////////////////
// handler functions - page unit functions //
/////////////////////////////////////////////
private function pageUnitClickHandler(evt:MouseEvent):void
{
	var pageUnit:PageUnit = PageUnit(evt.currentTarget);
	this.mainContainer.showPageUnit(pageUnit);
}

////////////////////////////////////////////
// handler functions - sel item functions //
////////////////////////////////////////////
private function bgImgSelectedHandler(evt:PageUnitEvent):void
{
//	var selBgImgUnit:SelBgImgUnit = SelBgImgUnit(evt.curPageUnit);
//	if (this.mainContainer.selectedPageUnit != null) {
//		var curPageUnit:PageUnit = PageUnit(this.mainContainer.selectedPageUnit);
//		curPageUnit.backgroundImage = selBgImgUnit.backgroundImage;
//		curPageUnit.validateBgImg();
//	}
}

///////////
// utils //
///////////
private function addPageUnit(pageStyle:PageStyle):PageUnit
{
	var pageUnit:PageUnit = mainContainer.addPageByStyle(pageStyle);
	pageUnit.addEventListener(MouseEvent.CLICK, pageUnitClickHandler);
	return pageUnit;
}
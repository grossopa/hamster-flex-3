// ActionScript file
import noorg.controls.album.units.PageUnit;
import noorg.events.PageUnitEvent;
import noorg.models.album.PageStyle;
import noorg.services.DataService;

private const DS:DataService = DataService.getInstance();

public var itemWidth:Number = 100;

public function get itemHeight():Number
{
	return this.itemWidth / DS.ratio;
}

public function get selectedPageUnit():PageUnit
{
	for each (var child:PageUnit in this.getChildren()) {
		if (child.selected) {
			return child;
		}
	}
	return null;
}

public function addPageByStyle(pageStyle:PageStyle = null):PageUnit
{
	var newPage:PageUnit = new PageUnit();
	if (pageStyle == null) {
	} else {
		newPage.pageStyle = pageStyle.clone();
	}
	return this.addPageUnit(newPage);
}

public function addPageUnit(pageUnit:PageUnit):PageUnit
{
	return this.addPageUnitAt(pageUnit, this.numChildren);
}

public function addPageUnitAt(pageUnit:PageUnit, index:int):PageUnit
{
	pageUnit.width = itemWidth;
	pageUnit.height = itemHeight;
	return PageUnit(this.addChildAt(pageUnit, index));
}

public function removePageUnitAt(index:int):PageUnit
{
	return this.removePageUnit(this.getPageUnitAt(index));
}

public function removePageUnit(pageUnit:PageUnit):PageUnit
{
	return PageUnit(this.removeChild(pageUnit));
}

public function getPageUnitAt(index:int):PageUnit
{
	return PageUnit(this.getChildAt(index));
}

public function getPageUnitIndex(pageUnit:PageUnit):int
{
	return this.getChildIndex(pageUnit);
}

public function selectPageUnit(pageUnit:PageUnit = null):void
{
	for each (var pgUnit:PageUnit in this.getChildren()) {
		pgUnit.styleName = "pageUnitUnselected";
	}
	
	if (pageUnit != null) {
		pageUnit.styleName = "pageUnitSelected";
		pageUnit.selected = true;
		var disEvt:PageUnitEvent = new PageUnitEvent(PageUnitEvent.SELECT_PAGEUNIT, true);
		disEvt.curPageUnit = pageUnit;
		this.dispatchEvent(disEvt);
	}
}

public function selectPageUnitAt(index:int):void
{
	this.selectPageUnit(getPageUnitAt(index));
}

private function updateItemSize():void
{
	
}
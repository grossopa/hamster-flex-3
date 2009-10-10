// ActionScript file
import noorg.events.InitDataEvent;
import noorg.models.album.PageStyle;
import noorg.services.DataService;
import noorg.services.EventService;
import noorg.utils.factories.ItemFactory;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private function completeHandler():void
{
	ES.addEventListener(InitDataEvent.INIT_DATA_COMPLETE, initDataCompleteHandler);
}

private function initDataCompleteHandler(evt:InitDataEvent):void
{
	for each (var pageStyle:PageStyle in DS.pageStyles) {
		this.mainContainer.addPageUnit(ItemFactory.createSelImgPosUnit(pageStyle));
	}
}
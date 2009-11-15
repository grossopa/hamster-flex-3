
import noorg.magic.events.StepCtrlEvent;
import noorg.magic.services.DataService;
import noorg.magic.utils.GlobalUtil;

public static const DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	this.playerConf1.addEventListener(StepCtrlEvent.LOAD_COMPLETE, loadCompleteHandler);
	this.playerConf2.addEventListener(StepCtrlEvent.LOAD_COMPLETE, loadCompleteHandler);
}

private function goNextHandler():void
{
	this.playerConf1.load();
	this.playerConf2.load();
	GlobalUtil.popUpMask(this.resourceManager.getString("main", "loading"));
}

private function loadCompleteHandler(evt:StepCtrlEvent):void
{
	if (this.playerConf1.player != null && this.playerConf2.player != null) {
		GlobalUtil.removePopUpMask();
		DS.playerRed = this.playerConf1.player;
		DS.playerBlue = this.playerConf2.player;
		this.dispatchEvent(new StepCtrlEvent(StepCtrlEvent.NEXT));
	}
}
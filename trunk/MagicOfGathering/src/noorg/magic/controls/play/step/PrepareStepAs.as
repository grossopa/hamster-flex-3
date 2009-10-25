// ActionScript file
import noorg.magic.events.StepCtrlEvent;

private function completeHandler():void
{
	chooseStepView.addEventListener(StepCtrlEvent.NEXT, finishChooseHandler);
}

private function finishChooseHandler(evt:StepCtrlEvent):void
{
	mainViewStack.selectedIndex = 1;
}
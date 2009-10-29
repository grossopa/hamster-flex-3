// ActionScript file
import mx.rpc.IResponder;
import mx.rpc.Responder;

import noorg.magic.events.StepCtrlEvent;

private function completeHandler():void
{
	chooseStepView.addEventListener(StepCtrlEvent.NEXT, finishChooseHandler);
}

private function finishChooseHandler(evt:StepCtrlEvent):void
{
	var responder:IResponder = new mx.rpc.Responder(null, null);
	mainViewStack.selectedIndex = 1;
	
	this.dispatchEvent(new StepCtrlEvent(StepCtrlEvent.FINISH));
}
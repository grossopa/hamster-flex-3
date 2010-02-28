// ActionScript file
import flash.events.Event;

import mx.controls.Alert;

private function completeHandler():void
{
	prepareView.addEventListener("startGame", startGameHandler);
}

private function startGameHandler(evt:Event):void
{
	mainViewStack.selectedIndex = 1;
}
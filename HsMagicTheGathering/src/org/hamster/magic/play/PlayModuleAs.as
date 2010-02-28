// ActionScript file
import flash.events.Event;

import mx.controls.Alert;

private function completeHandler():void
{
	prepareView.addEventListener("startGame", startGameHandler);
	Alert.show(this.resourceManager.getString('main','tap'));
}

private function startGameHandler(evt:Event):void
{
	mainViewStack.selectedIndex = 1;
}
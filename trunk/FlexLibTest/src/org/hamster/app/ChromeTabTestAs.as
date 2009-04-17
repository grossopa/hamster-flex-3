
import flash.display.DisplayObject;

import mx.containers.Canvas;

private function appComplete():void
{
	viewStack.y = 25;
	this.addChild(viewStack);
}

public function beforeAddTab(index:int):Boolean {
	return true;
}

public function createViewStackChild():DisplayObject
{
	var canvas:Canvas = new Canvas();
	canvas.width = Application.application.width;
	canvas.height = Application.application.height;
	canvas.setStyle("backgroundColor", Math.floor(Math.random() * 256 * 256 * 256));
	return canvas;
}

public function beforeSelectTab(index:int):Boolean {
	return true;
}

public function beforeCloseTab(index:int):Boolean {
	return true;
}
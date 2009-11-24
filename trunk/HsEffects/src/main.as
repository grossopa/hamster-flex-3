// ActionScript file
import com.flashdynamix.utils.SWFProfiler;

import flash.display.GradientType;
import flash.display.Graphics;

import mx.core.UIComponent;
import mx.core.mx_internal;
import mx.events.ChildExistenceChangedEvent;

import org.hamster.effects.SplitFadeZoom;
import org.hamster.effects.SplitMove;
use namespace mx_internal;

private var overlayUI:UIComponent;

private function leftHandler():void
{
}

private function rightHandler():void
{
}

private function completeHandler():void
{
	SWFProfiler.init(this.stage, this);
	SWFProfiler.start();
}

private function overlayCreatedHandler(evt:ChildExistenceChangedEvent):void
{
}

private function beginAni():void
{
	var split:SplitMove = new SplitMove(this.canvas);
	split.columnCount = 140;
	split.rowCount = 140;
//	split.zoomFrom = 0.3;
//	split.zoomTo = 1;
	split.duration = 2000;
	split.play();	
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	if (canvas) {
		var g:Graphics = canvas.graphics;
		g.clear();
		g.beginGradientFill(GradientType.LINEAR, [0x000000, 0xff0000],[1, 1],[0, 0xFF]);
		g.drawRect(0, 0, canvas.width, canvas.height);
		g.endFill();
	}
}
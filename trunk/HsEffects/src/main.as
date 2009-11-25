// ActionScript file
import com.flashdynamix.utils.SWFProfiler;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

import mx.core.UIComponent;
import mx.core.mx_internal;
import mx.effects.easing.Linear;
import mx.events.ChildExistenceChangedEvent;

import org.hamster.effects.RainDrop;
import org.hamster.effects.SplitMass;
use namespace mx_internal;

private var overlayUI:UIComponent;

[Embed(source="org/hamster/assets/snowflake.png")]
private var snow_flake:Class;

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
	var split:SplitMass = new SplitMass(this.canvas);
	split.columnCount = 100;
	split.rowCount = 100;
//	split.zoomFrom = 0.3;
//	split.zoomTo = 1;
	//split.aniType = SplitShowImage.FROM_POINTS;
	split.duration = 5000;
	split.play(null);	
}

private function beginAni2():void
{
	var bm:Bitmap = new snow_flake();
	var m:Matrix = new Matrix();
	m.scale(0.3, 0.3);
	var bd:BitmapData = new BitmapData(0.3 * bm.width, 0.3 * bm.height, true, 0x00);
	var bd2:BitmapData = new BitmapData(0.5 * bm.width, 0.5 * bm.height, true, 0x00);
	bd.draw(bm.bitmapData, m);
	var m2:Matrix = new Matrix();
	m2.scale(0.5, 0.5);
	bd2.draw(bm.bitmapData, m2);
	var drop:RainDrop = new RainDrop(bgCanvas);
	drop.duration = 30000;
	drop.dropDuration = 5000;
	drop.easingFunction = Linear.easeNone;
	drop.bitmapDataList = [bd, bd2];
	drop.play();
	
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
//	if (canvas) {
//		var g:Graphics = canvas.graphics;
//		g.clear();
//		g.beginGradientFill(GradientType.LINEAR, [0x000000, 0xff0000],[1, 1],[0, 0xFF]);
//		g.drawRect(0, 0, canvas.width, canvas.height);
//		g.endFill();
//	}
}
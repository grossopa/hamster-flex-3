// ActionScript file
import com.flashdynamix.utils.SWFProfiler;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.TimerEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.utils.Timer;

import mx.core.UIComponent;
import mx.core.mx_internal;
import mx.effects.easing.Bounce;
import mx.effects.easing.Linear;
import mx.events.ChildExistenceChangedEvent;
import mx.events.EffectEvent;

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
	split.startPoint = new Point(this.canvas.width / 2, this.canvas.height / 2);
	split.aniType = SplitMass.FROM_POINTS;
	
//	var pa:Array = new Array();
//	for (var i:int = 0; i < 10000; i++) {
//		pa.push(new Point(-10, Math.random() * this.canvas.height));
//		pa.push(new Point(this.canvas.width + 10, Math.random() * this.canvas.height));
//	}
//	split.startPoints = pa;
	
	
//	split.startPoints = [
//			new Point(this.canvas.width / 4 ,    this.canvas.height / 4), 
//			new Point(this.canvas.width / 4 * 3, this.canvas.height / 4), 
//			new Point(this.canvas.width / 4 * 3, this.canvas.height / 4 * 3), 
//			new Point(this.canvas.width / 4 ,    this.canvas.height / 4 * 3)
//	];
	split.addEventListener(EffectEvent.EFFECT_END, effEndHandler);
	split.duration = 5000;Bounce;
	//split.easingFunction = Bounce.easeIn;
	split.play(null);
}

private function effEndHandler(evt:EffectEvent):void
{
	var timer:Timer = new Timer(3000, 1);
	timer.addEventListener(TimerEvent.TIMER, timerCompleteHandler);
	timer.start();

}

private function timerCompleteHandler(evt:TimerEvent):void
{
	var split:SplitMass = new SplitMass(this.canvas);
	split.columnCount = 100;
	split.rowCount = 100;
	// split.startPoint = new Point(this.canvas.width / 2, this.canvas.height / 2);
	split.aniType = SplitMass.FROM_POINTS;
	
	var pa:Array = new Array();
	for (var i:int = 0; i < 5000; i++) {
		pa.push(new Point(-10, Math.random() * this.canvas.height));
		pa.push(new Point(this.canvas.width + 10, Math.random() * this.canvas.height));
	}
	split.startPoints = pa;
	
	
//	split.startPoints = [
//			new Point(this.canvas.width / 4 ,    this.canvas.height / 4), 
//			new Point(this.canvas.width / 4 * 3, this.canvas.height / 4), 
//			new Point(this.canvas.width / 4 * 3, this.canvas.height / 4 * 3), 
//			new Point(this.canvas.width / 4 ,    this.canvas.height / 4 * 3)
//	];
	split.duration = 5000;
	//split.easingFunction =  Bounce.easeOut;
	split.play(null, true);		
}

private function beginAni2():void
{
	var bm:Bitmap = new snow_flake();
	var m:Matrix = new Matrix();
	m.scale(0.3, 0.3);
	var m2:Matrix = new Matrix();
	m2.scale(0.4, 0.4);
	var bd:BitmapData = new BitmapData(0.3 * bm.width, 0.3 * bm.height, true, 0x00);
	var bd2:BitmapData = new BitmapData(0.4 * bm.width, 0.4 * bm.height, true, 0x00);
	bd.draw(bm.bitmapData, m);
	bd2.draw(bm.bitmapData, m2);
	var drop:RainDrop = new RainDrop(bgCanvas);
	drop.rockHorizontal = 5;
	drop.rockSpeed = 0.01;
	drop.duration = 120000;
	drop.dropDuration = 10000;
	drop.intervalDuration = 100;
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
// ActionScript file
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

import mx.effects.easing.Linear;

import org.hamster.effects.RainDrop;

[Embed(source="org/hamster/assets/snowflake.png")]
private var snow_flake:Class;

private function completeHandler():void
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
	var drop:RainDrop = new RainDrop(mainCanvas);
	drop.rockHorizontal = 5;
	drop.rockSpeed = 0.01;
	drop.duration = 1200000;
	drop.dropDuration = 10000;
	drop.intervalDuration = 100;
	drop.easingFunction = Linear.easeNone;
	drop.bitmapDataList = [bd, bd2];
	drop.play();
}
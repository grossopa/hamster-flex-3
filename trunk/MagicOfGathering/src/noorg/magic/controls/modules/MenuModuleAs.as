// ActionScript file
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import mx.effects.Fade;
import mx.effects.Parallel;
import mx.effects.easing.Linear;

import org.hamster.effects.SplitMass;

private var _timer:Timer;

private function startGameHandler():void
{
	this.dispatchEvent(new Event("startGame"));
}

private function completeHandler():void
{
	this.alpha = 0;
	_timer = new Timer(1000, 1);
	_timer.addEventListener(TimerEvent.TIMER, timerHandler);
	_timer.start();
}

private function timerHandler(evt:TimerEvent):void
{
	_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
	
	var parallel:Parallel = new Parallel(this);
	
	var fade:Fade = new Fade(this);
	fade.alphaFrom = 0;
	fade.alphaTo = 1;
	
	var split:SplitMass = new SplitMass(this);
	split.startPoints = [
							new Point(0,0), 
							new Point(this.width, 0),
							new Point(this.width, this.height), 
							new Point(0, this.height)
						];
	split.columnCount = 100;
	split.rowCount = 70;
	
	parallel.addChild(split);
	parallel.addChild(fade);
	
	parallel.duration = 8000;
	parallel.play();
}
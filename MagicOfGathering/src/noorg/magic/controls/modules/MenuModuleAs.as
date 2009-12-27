// ActionScript file
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import mx.containers.Canvas;
import mx.effects.Fade;
import mx.effects.Parallel;
import mx.managers.PopUpManager;

import noorg.magic.controls.common.popup.BasePopup;
import noorg.magic.controls.popups.SettingsPopup;

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

private function popupSettingsHandler():void
{
	var pop:SettingsPopup = PopUpManager.createPopUp(this, SettingsPopup, true) as SettingsPopup;
	PopUpManager.centerPopUp(pop);
}
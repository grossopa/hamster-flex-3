// ActionScript file
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import mx.controls.Alert;
import mx.effects.Fade;
import mx.effects.Parallel;
import mx.events.EffectEvent;
import mx.managers.PopUpManager;

import noorg.magic.controls.popups.SettingsPopup;
import noorg.magic.controls.views.CardConfigurationView;
import noorg.magic.events.GameFlowEvent;
import noorg.magic.services.DataService;

import org.hamster.effects.SplitMass;

private static const DS:DataService = DataService.getInstance();

private var _timer:Timer;
private var _parallel:Parallel;

private function startGameHandler():void
{
	if (DS.userCollNames != null && DS.userCollNames.length > 0) {
		_parallel.addEventListener(EffectEvent.EFFECT_END, hideEffectEndHandler);
		_parallel.play(null, true);
	} else {
		Alert.show("");
	}
}

private function hideEffectEndHandler(evt:EffectEvent):void
{
	this.dispatchEvent(new GameFlowEvent(GameFlowEvent.START_GAME));
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
	
	_parallel = new Parallel(this);
	
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
	
	_parallel.addChild(split);
	_parallel.addChild(fade);
	
	_parallel.duration = 3000;
	_parallel.play();
}

private function popupSettingsHandler():void
{
	var pop:SettingsPopup = PopUpManager.createPopUp(this, SettingsPopup, true) as SettingsPopup;
	PopUpManager.centerPopUp(pop);
}

private function switchCardConfView():void
{
	var cardConf:CardConfigurationView = new CardConfigurationView();
	this.addChild(cardConf);
	cardConf.showView();
}
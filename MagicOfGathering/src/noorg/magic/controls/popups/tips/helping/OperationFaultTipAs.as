// ActionScript file
import mx.effects.Fade;
import mx.events.EffectEvent;
import mx.managers.PopUpManager;


[Bindable]
private var _mainText:String;
private var _fade:Fade = new Fade(this);

public function showTip(text:String):void
{
	this._mainText = text;
	_fade.alphaFrom = 0;
	_fade.alphaTo = 1;
	_fade.duration = 500;
	_fade.play();
}

public function clickHandler():void
{
	if (_fade.isPlaying) {
		_fade.stop();
		_fade.alphaFrom = this.alpha;
		_fade.alphaTo = 0;
		_fade.addEventListener(EffectEvent.EFFECT_END, effEndHandler);
		_fade.play();
	}
}

private function effEndHandler(evt:EffectEvent):void
{
	this.visible = false;
	PopUpManager.removePopUp(this);
}
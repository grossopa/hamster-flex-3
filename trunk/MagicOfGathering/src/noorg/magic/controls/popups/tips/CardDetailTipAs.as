// ActionScript file
import mx.effects.Fade;
import mx.events.EffectEvent;

import noorg.magic.controls.play.unit.PlayCardUnit;
import noorg.magic.controls.popups.tips.TipBase;
import noorg.magic.models.Card;
import noorg.magic.utils.Constants;
import noorg.magic.utils.TipArrowUtil;Constants;

public static const FADE_DURATION:Number = 250;

private var _card:Card;
private var _fade:Fade = new Fade();

public function set card(value:Card):void
{
	this._card = card;
	if (this.initialized) {
		mainCardUnit.card = value;
		if (this.tipArrow.arrowDirection == TipArrowUtil.TOP) {
		} else {
		}
		this.invalidateDisplayList();
	}
}

public function get card():Card
{
	return this._card;
}

private function completeHandler():void
{
	if (card != null) {	
		mainCardUnit.card = card;
	}
	this.visible = false;
	this.alpha = 0;
	
	_fade.target = this;
	_fade.addEventListener(EffectEvent.EFFECT_END, fadeEndHandler);
}

public function showTip(playCardUnit:PlayCardUnit):void
{
	this.card = playCardUnit.card;
	
	this.visible = true;
	_fade.stop();
	_fade.alphaFrom = this.alpha;
	_fade.alphaTo = 1;
	_fade.duration = (1 - this.alpha) * FADE_DURATION;
	_fade.play();
}

public function hideTip():void
{
	_fade.stop();
	_fade.alphaFrom = this.alpha;
	_fade.alphaTo = 0;
	_fade.duration = this.alpha * FADE_DURATION;
	_fade.play();
}

private function fadeEndHandler(evt:EffectEvent):void
{
	if (_fade.alphaTo == 0 && this.alpha == 0) {
		this.visible = false;
	}
}
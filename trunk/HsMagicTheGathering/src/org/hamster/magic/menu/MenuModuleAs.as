// ActionScript file
import mx.effects.Fade;
import mx.effects.Move;
import mx.effects.Parallel;
import mx.events.EffectEvent;

import org.hamster.magic.common.events.HsModuleEvent;

public function startGame():void
{
	var parallel:Parallel = new Parallel();
	
	var move1:Move = new Move(this.startGameButton);
	move1.xBy = 250;
	move1.duration = 1000;
	parallel.addChild(move1);
	
	var move2:Move = new Move(this.gameSettingsButton);
	move2.xBy = 250;
	move2.startDelay = 250;
	move2.duration = 1000;
	parallel.addChild(move2);
	
	var fade:Fade = new Fade(this.backgroundCanvas);
	fade.alphaFrom = 1;
	fade.alphaTo = 0;
	fade.duration = 1500;
	parallel.addChild(fade);
	
	parallel.duration = 1500;
	parallel.addEventListener(EffectEvent.EFFECT_END, effEndHandler);
	parallel.play();
}

private function effEndHandler(evt:EffectEvent):void
{
	this.dispatchEvent(new HsModuleEvent(HsModuleEvent.CLOSE));
}
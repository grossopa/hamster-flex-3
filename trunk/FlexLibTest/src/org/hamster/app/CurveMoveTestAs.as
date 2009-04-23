// ActionScript file
import flash.display.Graphics;

import mx.effects.Move;
import mx.effects.easing.Linear;
import mx.events.EffectEvent;

import org.hamster.effects.SinMove;

public function appComplete():void
{
	var g:Graphics = moveTarget.graphics;
	g.beginFill(0xFFFFFF, 0.8);
	g.drawCircle(moveTarget.width >> 1, moveTarget.height >> 1, moveTarget.width >> 1);
	g.endFill();
	
	var sinMove:SinMove = new SinMove(moveTarget);
	sinMove.duration = 8000;
	sinMove.a = 100;
	sinMove.b = 1 / 50;
	sinMove.c = Math.PI / 4;
	sinMove.d = 400;
	sinMove.xFrom = 0;
	sinMove.xTo = 1000;
	sinMove.easingFunction = Linear.easeNone;
	sinMove.play(null, true);
}
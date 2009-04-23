// ActionScript file
import flash.display.Graphics;

import mx.effects.easing.Linear;
import mx.events.EffectEvent;

import org.hamster.effects.CircleMove;
import org.hamster.effects.SinMove;

public static const DURATION:Number = 5000;

public function appComplete():void
{
	var g:Graphics = moveTarget.graphics;
	g.beginFill(0xFFFFFF, 0.8);
	g.drawCircle(moveTarget.width >> 1, moveTarget.height >> 1, moveTarget.width >> 1);
	g.endFill();
	
	sinMoveTest();
}

public function sinMoveTest():void
{
	var sinMove:SinMove = new SinMove(moveTarget);
	sinMove.duration = DURATION;
	sinMove.a = 100;
	sinMove.b = 1 / 50;
	sinMove.c = Math.PI / 4;
	sinMove.d = 400;
	sinMove.xFrom = 0;
	sinMove.xTo = 1000;
	sinMove.easingFunction = Linear.easeNone;
	sinMove.play();
	
	sinMove.addEventListener(EffectEvent.EFFECT_END, circleMoveTest);
}

public function circleMoveTest(evt:EffectEvent):void
{
	var circleMove:CircleMove = new CircleMove(moveTarget);
	circleMove.duration = DURATION;
	circleMove.angleFrom = Math.PI / 2;
	circleMove.angleTo = Math.PI * 6;
	circleMove.oX = this.width >> 1;
	circleMove.oY = this.height >> 1;
	circleMove.radius = 200;
	circleMove.easingFunction = Linear.easeNone;
	circleMove.play();
}
// ActionScript file
import flash.display.Graphics;
import flash.events.Event;

import mx.effects.easing.Exponential;
import mx.effects.easing.Linear;
import mx.events.EffectEvent;
import mx.events.TweenEvent;

import org.hamster.effects.ArchimedesSpiralMove;
import org.hamster.effects.CircleMove;
import org.hamster.effects.EllipseMove;
import org.hamster.effects.NikeMove;
import org.hamster.effects.SinMove;
import org.hamster.log.Logger;
import org.hamster.log.LoggerPanel;

public static const DURATION:Number = 5000;

private var logger:Logger;

public var curColor:uint;

public function appComplete():void
{
	var g:Graphics = moveTarget.graphics;
	g.beginFill(0xFF0000, 0.8);
	g.drawCircle(moveTarget.width >> 1, moveTarget.height >> 1, moveTarget.width >> 1);
	g.endFill();
	LoggerPanel.getInstance().setLogMode(LoggerPanel.HTML_MODE | LoggerPanel.PANEL_MODE);
	LoggerPanel.getInstance().levelValue = 3;
	logger = Logger.getLogger("CurveTest");
	sinMoveTest();
}

public function onTweenUpdate(evt:Event):void
{
	drawCanvas.graphics.beginFill(curColor,0.6);
	drawCanvas.graphics.drawCircle(moveTarget.x + moveTarget.width / 2, moveTarget.y + moveTarget.height / 2, 5);
	drawCanvas.graphics.endFill();
	
	logger.traceValue(moveTarget.x.toFixed(3).toString() + "   " + moveTarget.y.toFixed(3).toString());
}

public static function easeNone(t:Number, b:Number,
								  c:Number, d:Number):Number
{
	return c * t / d + b;
}

public function sinMoveTest():void
{
	curColor = 0xFF0000;
	var sinMove:SinMove = new SinMove(moveTarget);
	sinMove.duration = DURATION;
	sinMove.a = 100;
	sinMove.b = 1 / 50;
	sinMove.c = Math.PI / 4;
	sinMove.d = 400;
	sinMove.xFrom = 0;
	sinMove.xTo = 800;
	sinMove.easingFunction = easeNone;
	sinMove.addEventListener(TweenEvent.TWEEN_UPDATE, onTweenUpdate);
	sinMove.play();
	
	sinMove.addEventListener(EffectEvent.EFFECT_END, circleMoveTest);
}

public function circleMoveTest(evt:EffectEvent):void
{
	curColor = 0x007F7F;
	
	var circleMove:CircleMove = new CircleMove(moveTarget);
	circleMove.duration = DURATION;
	circleMove.angleFrom = Math.PI / 2;
	circleMove.angleTo = Math.PI * 6;
	circleMove.oX = this.width >> 1;
	circleMove.oY = this.height >> 1;
	circleMove.radius = 200;
	circleMove.easingFunction = easeNone;
	circleMove.addEventListener(TweenEvent.TWEEN_UPDATE, onTweenUpdate);
	circleMove.play();
	
	circleMove.addEventListener(EffectEvent.EFFECT_END, ellipseMoveTest);
}

public function ellipseMoveTest(evt:EffectEvent):void
{
	curColor = 0x7F7F00;
	
	var ellipseMove:EllipseMove = new EllipseMove(moveTarget);
	ellipseMove.duration = DURATION;
	ellipseMove.angleFrom = Math.PI / 2;
	ellipseMove.angleTo = Math.PI * 6;
	ellipseMove.oX = this.width >> 1;
	ellipseMove.oY = this.height >> 1;
	ellipseMove.a = 200;
	ellipseMove.b = 70;
	ellipseMove.easingFunction = easeNone;
	ellipseMove.addEventListener(TweenEvent.TWEEN_UPDATE, onTweenUpdate);
	ellipseMove.play();
	
	ellipseMove.addEventListener(EffectEvent.EFFECT_END, asMoveTest);
}

public function asMoveTest(evt:EffectEvent):void
{
	curColor = 0x00007F;
	
	var asMove:ArchimedesSpiralMove = new ArchimedesSpiralMove(moveTarget);
	asMove.duration = DURATION;
	asMove.angleFrom = 0;
	asMove.angleTo = Math.PI * 8;
	asMove.oX = this.width >> 1;
	asMove.oY = this.height >> 1;
	asMove.a = 20;
	asMove.easingFunction = easeNone;
	asMove.addEventListener(TweenEvent.TWEEN_UPDATE, onTweenUpdate);
	asMove.play();
	
	asMove.addEventListener(EffectEvent.EFFECT_END, nikeMoveTest);
}

public function nikeMoveTest(evt:EffectEvent):void
{
	curColor = 0x7F7F7F;
	
	var nikeMove:NikeMove = new NikeMove(moveTarget);
	nikeMove.duration = DURATION;
	nikeMove.xFrom = 150;
	nikeMove.xTo = 900;
	nikeMove.oX = 0;
	nikeMove.oY = 1000;
	nikeMove.a = -1;
	nikeMove.b = -90000;
	nikeMove.easingFunction = easeNone;
	nikeMove.addEventListener(TweenEvent.TWEEN_UPDATE, onTweenUpdate);
	nikeMove.play();
}
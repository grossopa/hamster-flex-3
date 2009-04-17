package org.hamster.effects.advancedviewstack.base
{
	public interface IAdvancedViewStackEffect
	{
		function get eff1():Array;
		function get eff2():Array;
		function get isQueue():Boolean;
		function get type():String;
		function advInitFunction(imgs1:Array, imgs2:Array):void;
		function initAnimation():void;
	}
}
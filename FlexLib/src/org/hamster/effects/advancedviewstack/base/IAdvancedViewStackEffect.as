package org.hamster.effects.advancedviewstack.base
{
	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * This interface is for AdvancedViewStack usage.
	 */
	public interface IAdvancedViewStackEffect
	{
		/**
		 * @return effects for current images.
		 */
		function get eff1():Array;
		
		/**
		 * @return effects for next images.
		 */
		function get eff2():Array;
		
		/**
		 * if an animation is queue, then the AdvancedViewStack will play 
		 * all eff1 effects then play eff2 effects. Else they will play at
		 * the same time.
		 * 
		 * @return whether the animation is queue mode.
		 */
		function get isQueue():Boolean;
		
		/**
		 * @return type of this effect.
		 */
		function get type():String;
		
		/**
		 * This function will only be called inside AdvancedViewStack.
		 * The imgs1 will contain a image shot of ViewStack origin child.
		 * The imgs2 will contain a image shot of ViewStack origin child.
		 * if you want do do some extra work (such as split the images to
		 * blocks and move them to different location), you can reference
		 * org.hamster.effects.advancedviewstack.AdvSplit9AVS.
		 * 
		 * @param imgs1 current images array.
		 * @param imgs2 next images array.
		 */
		function advInitFunction(imgs1:Array, imgs2:Array):void;
		
		/**
		 * for init all effects.
		 * 
		 * Pay attention!
		 * the targets of each effect in _eff1 & _eff2 arrays are assert to 
		 * be same as imgs1 & imgs2 arrays.  So you should make sure that 
		 * 
		 * _eff1.length == imgs1.length & _eff2.length == imgs2.length
		 * 
		 * _eff1[0].target = imgs1[0];
		 * _eff1[1].target = imgs1[1];
		 * _eff1[2].target = imgs1[2];
		 * ....
		 * 
		 * _eff2[0].target = imgs2[0];
		 * _eff2[1].target = imgs2[1];
		 * ....
		 * 
		 */
		function initAnimation():void;
	}
}
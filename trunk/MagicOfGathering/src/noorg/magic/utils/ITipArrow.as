package noorg.magic.utils
{
	import flash.display.Graphics;
	
	/**
	 *             h
	 *            /|\
	 *      /----a   b----\
	 *      |             |
	 *      a             a
	 *     /               \ 
	 *    h-               -h
	 *     \               /
	 *      b             b
	 *      |             |
	 *      \----a   b----/
	 *            \|/ 
	 *             h
	 * if horizontal (TOP|BOTTOM) then equals paddingLeft,
	 * else if vertical (LEFT|RIGHT) then equals paddingTop.
	 * 
	 */
	public interface ITipArrow
	{
		function set arrowDirection(value:uint):void
	 	function get arrowDirection():uint;	
		function set distanceA(value:Number):void;
		function get distanceA():Number;
		function set distanceB(value:Number):void;
		function get distanceB():Number;
		function set tipHeight(value:Number):void;
		function get tipHeight():Number;
		/**
		 * draw tip method. 
		 */
		function drawTip(g:Graphics, startX:Number, startY:Number,
				endX:Number, endY:Number):void;
	}
}
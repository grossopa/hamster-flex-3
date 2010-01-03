package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	
	import mx.effects.effectClasses.FadeInstance;

	/**
	 * Instance class of WaterDissolve.
	 * 
	 * @see org.hamster.effects.WaterDissolve
	 */
	public class WaterDissolveInstance extends FadeInstance
	{
		/**
		 * Default max value of <code>BlurFilter</code>.
		 */
		public static const BLUR_END:Number = 20;
		
		/**
		 * For both <code>_perlinBd.parlinNoise.baseX</code> and <code>_perlinBd.parlinNoise.baseY</code>.
		 */
		private var _baseValue:Number = 50;
		
		/**
		 * @private 
		 *
		 * Perlin noise bitmapData.
		 */
		private var _perlinBd:BitmapData;
		
		/**
		 * @private
		 */
		private var _perlinOffset:Array;
		
		/**
		 * @private
		 */
		private var _displacementMapFilter:DisplacementMapFilter;
		
		/**
		 * @private
		 */
		private var _blurFilter:BlurFilter;
		
		/**
		 * @private
		 */
		public function WaterDissolveInstance(target:Object)
		{
			super(target);
		}
		
		/**
		 * @private
		 */
		override public function play():void
		{
			_perlinOffset = [new Point(), new Point()];
			_perlinBd = new BitmapData(target.width, target.height, true, 0x000000);
			_displacementMapFilter = new DisplacementMapFilter(_perlinBd, new Point(),1, 1, 4, 4, "color", 0xFFFFFF, 0);
			_blurFilter = new BlurFilter(0, 0, 3);
			
			super.play();
		}
		
		/**
		 * @private
		 */
		override public function onTweenUpdate(value:Object):void
		{
			var numValue:Number = Number(value);
			
			_perlinOffset[0].y -= 8;
			_perlinOffset[0].x -= 5;
			_perlinOffset[1].x += 8;
			_perlinOffset[1].y += 5;
			
			_perlinBd.perlinNoise(_baseValue, _baseValue, 3, 10, false, true, 1, true, _perlinOffset);
			_blurFilter.blurX = BLUR_END * (1 - numValue);
			_blurFilter.blurY = _blurFilter.blurX;
			setWaterFilter();
			
			super.onTweenUpdate(value);
		}
		
		/**
		 * @private
		 */
		override public function onTweenEnd(value:Object):void
		{
			super.onTweenEnd(value);
			removeFilters();
		}
		
		/**
		 * @private
		 */
		private function setWaterFilter():void
		{
			var filters:Array = target.filters;
		
			removeFilters();
			
			filters.push(this._displacementMapFilter);
			filters.push(this._blurFilter);
			
			target.filters = filters;
		}
		
		/**
		 * @private
		 */
		private function removeFilters():void
		{
			var filters:Array = target.filters;
		
			var n:int = filters.length;
			for (var i:int = 0; i < n; i++)
			{
				if (filters[i] is DisplacementMapFilter)
					filters.splice(i, 1);
					
				if (filters[i] is BlurFilter) {
					filters.splice(i, 1);
				}
			}
			
			target.filters = filters;		
		}
		
		
		
	}
}
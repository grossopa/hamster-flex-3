package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.LocalConnection;
	
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.effectClasses.TweenEffectInstance;
	import mx.events.ChildExistenceChangedEvent;
	import mx.graphics.RoundedRectangle;
	
	use namespace mx_internal;
	
	/**
	 * <p>Instance class of <code>org.hamster.effects.Split</code>.</p>
	 */
	public class SplitInstance extends TweenEffectInstance
	{
		/**
		 * origin bitmap data list, sub classes should use
		 * this array for drawing.
		 */
		protected var _bitmapDataList:Array;
		
		/**
		 * bitmap data list for drawing, sub classes should
		 * use this list to finish drawing work to avoid
		 * new operation.
		 */
		protected var _bdDrawList:Array;
		
		/**
		 * temporary bitmap palette, use <code>BitmapData.copyPixels</code>
		 * to copy pixels to _bdDraw rather than using new operation.
		 */
		protected var _bdDraw:BitmapData;
		
		/**
		 * width of each block, don't set manually.
		 */
		protected var _smallWidth:Number;
		
		/**
		 * height of each block, don't set manually.
		 */
		protected var _smallHeight:Number;
		
		/**
		 * reference overlay of target.
		 */
		protected var _overlay:UIComponent;
		
		/**
		 * temporary object for each <code>copyPixels</code> operation.
		 */
		protected var _destPoint:Point = new Point();
		
		/**
		 * store background alpha value of target.
		 */
		private var _preBackgroundAlpha:Number = 1;
		
		/**
		 * row count of blocks
		 */
		public var rowCount:uint = 3;
		
		/**
		 * column count of blocks
		 */
		public var columnCount:uint = 3;
		
		/**
		 * return target as <code>UIComponent</code>
		 */
		public function get uiTarget():UIComponent
		{
			return UIComponent(target);
		}
		
		/**
		 * constructor
		 */
		public function SplitInstance(target:Object)
		{
			super(target);
		}
		
		/**
		 * Create snapshot of target and palette. Please note that
		 * super.play() is not called in this function, it will be called in
		 * <code>overlayCreatedHandler</code>.
		 */
		override public function play():void
		{
			// create Snapshot first
			createSnapshot();
			
			_bdDraw = new BitmapData(uiTarget.width, uiTarget.height, true, 0x00);
		}
		
		/**
		 * create overlay of target.
		 */
		protected function createSnapshot():void
		{
			_bitmapDataList = new Array();
			_bdDrawList = new Array();
			var uiTarget:UIComponent = UIComponent(this.target);
			
			var targetArea:RoundedRectangle = new RoundedRectangle(0, 0, 0, 0, 0);
			uiTarget.addEventListener(ChildExistenceChangedEvent.OVERLAY_CREATED, 
					overlayCreatedHandler);
			uiTarget.mx_internal::addOverlay(0xffffff, targetArea);
		}
		
		/**
		 * Overlay of target is created.
		 */
		private function overlayCreatedHandler(evt:ChildExistenceChangedEvent):void
		{
			uiTarget.removeEventListener(ChildExistenceChangedEvent.OVERLAY_CREATED,
					overlayCreatedHandler);
					
			_overlay = UIComponent(evt.relatedObject);
			_overlay.visible = true;
			beginPlay();
		}
		
		/**
		 * Initialize origin bitmapData list, temporary bitmapData list
		 * and start play effect.
		 */
		protected function beginPlay():void
		{
			// begin play
			super.play();
			
			this._bitmapDataList = new Array();
			this._bdDrawList = new Array();
			
			var bdTarget:BitmapData = new BitmapData(uiTarget.width, uiTarget.height, true, 0x00);
			bdTarget.draw(uiTarget);
			
			_smallWidth = bdTarget.width / columnCount;
			_smallHeight = bdTarget.height / rowCount;
			
			for (var i:int = 0; i < columnCount; i++) {
				for(var j:int = 0; j < rowCount; j++) {
					var bdChildren:BitmapData = new BitmapData(_smallWidth, _smallHeight, true, 0x00);
					bdChildren.copyPixels(bdTarget,
							new Rectangle(_smallWidth * i, _smallHeight * j, 
									_smallWidth, _smallHeight), 
							new Point());
					this._bitmapDataList.push(bdChildren);
					var bdDraw:BitmapData = new BitmapData(_smallWidth, _smallHeight, true, 0x00);
					this._bdDrawList.push(bdDraw);
				}
			}
			
			// I have to set visibility of all children of UIComponent to false
			_preBackgroundAlpha = Number(uiTarget.getStyle("backgroundAlpha"));
			uiTarget.setStyle("backgroundAlpha", 0);
			for (i = 0; i < uiTarget.numChildren; i++) {
				uiTarget.getChildAt(i).visible = false;
			}
			tween = createTween(this, 0, 1, duration);
		}
		
		/**
		 * Override this function in sub class
		 */
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
		}
		
		/**
		 * after tween effect end, clean overlay and reverse target.
		 */
		override public function onTweenEnd(value:Object):void
		{
			// clean
			UIComponent(target).mx_internal::removeOverlay();
			
			uiTarget.setStyle("backgroundAlpha", this._preBackgroundAlpha);
			for (var i:int = 0; i < uiTarget.numChildren; i++) {
				uiTarget.getChildAt(i).visible = true;
			}
			uiTarget.validateNow();
			
			// gc
			try {
				new LocalConnection().connect("justforgc");
				new LocalConnection().connect("justforgc");
			} catch (e:Error) { }
			
			super.onTweenEnd(value);
		}
	}
}
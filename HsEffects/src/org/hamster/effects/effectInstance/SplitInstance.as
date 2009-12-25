package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
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
	 * This is an abstract class so you must also extend this class if you extend
	 * <code>Split</code>. This class is instance class of <code>Split</code>.
	 * 
	 * @see org.hamster.effects.Split
	 */
	public class SplitInstance extends TweenEffectInstance
	{		
		/**
		 * Origin bitmap data list, stores all blocks of target UIComponent.
		 */
		protected var _bitmapDataList:Array;
		
		/**
		 * Bitmap data list for drawing, sub classes should
		 * use this list to finish drawing work to avoid
		 * new operation.
		 */
		protected var _bdDrawList:Array;
		
		/**
		 * Main bitmap palette, use <code>BitmapData.copyPixels</code>
		 * to copy pixels to _bdDraw rather than using new operation for performance.
		 */
		protected var _bdDraw:BitmapData;
		
		/**
		 * Width of each block, don't set manually.
		 */
		protected var _smallWidth:Number;
		
		/**
		 * Height of each block, don't set manually.
		 */
		protected var _smallHeight:Number;
		
		/**
		 * Overlay of target UIComponent.
		 */
		protected var _overlay:UIComponent;
		
		/**
		 * Temporary object for each <code>copyPixels</code> operation.
		 */
		protected var _destPoint:Point = new Point();
		
		/**
		 * Stores background alpha value of target.
		 */
		private var _preBackgroundAlpha:Number = 1;
		
		/**
		 * Visibility of all children.
		 */
		private var _preChildVisibleList:Array;
		
		/**
		 * Row count of blocks
		 */
		public var rowCount:uint = 3;
		
		/**
		 * Column count of blocks
		 */
		public var columnCount:uint = 3;
		
		/**
		 * Return target as <code>UIComponent</code>.
		 */
		public function get uiTarget():UIComponent
		{
			return UIComponent(target);
		}
		
		/**
		 * @private
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
		 * Create overlay of target.
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
			this._preChildVisibleList = new Array();
			
			var bdTarget:BitmapData = new BitmapData(uiTarget.width, uiTarget.height, true, 0x00);
			bdTarget.draw(uiTarget);
			
			_smallWidth = Math.ceil(bdTarget.width / columnCount);
			_smallHeight = Math.ceil(bdTarget.height / rowCount);
			
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
				_preChildVisibleList.push(uiTarget.getChildAt(i).visible);
				uiTarget.getChildAt(i).visible = false;
			}
			
			// fix twinkling issue
			var g:Graphics = this._overlay.graphics;
			g.beginBitmapFill(bdTarget);
			g.drawRect(0, 0, uiTarget.width, uiTarget.height);
			g.endFill();
			
			tween = createTween(this, 0, 1, duration);
		}
		
		/**
		 * Override this function in sub classes.
		 */
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
		}
		
		/**
		 * After tween effect end, clean overlay and reset target.
		 */
		override public function onTweenEnd(value:Object):void
		{
			// clean
			UIComponent(target).mx_internal::removeOverlay();
			
			uiTarget.setStyle("backgroundAlpha", this._preBackgroundAlpha);
			for (var i:int = 0; i < uiTarget.numChildren; i++) {
				uiTarget.getChildAt(i).visible = _preChildVisibleList[i] as Boolean;
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
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
	
	public class SplitInstance extends TweenEffectInstance
	{
		protected var _bitmapDataList:Array;
		protected var _bdDrawList:Array;
		protected var _bdDraw:BitmapData;
		protected var _mDraw:Matrix = new Matrix();
		protected var _smallWidth:Number;
		protected var _smallHeight:Number;
		protected var _overlay:UIComponent;
		protected var _destPoint:Point = new Point();
		protected var _zeroPoint:Point = new Point();
		private var _preBackgroundAlpha:Number = 1;
		
		public var rowCount:uint = 3;
		public var columnCount:uint = 3;
		
		public function get uiTarget():UIComponent
		{
			return UIComponent(target);
		}
		
		public function SplitInstance(target:Object)
		{
			super(target);
		}
		
		override public function play():void
		{
			// create Snapshot first
			createSnapshot();
			
			_bdDraw = new BitmapData(uiTarget.width, uiTarget.height, true, 0x00);
		}
		
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
		
		private function overlayCreatedHandler(evt:ChildExistenceChangedEvent):void
		{
			uiTarget.removeEventListener(ChildExistenceChangedEvent.OVERLAY_CREATED,
					overlayCreatedHandler);
					
			_overlay = UIComponent(evt.relatedObject);
			
			beginPlay();
		}
		
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
		 * override this function to make your own animations
		 */
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
		}
		
		override public function onTweenEnd(value:Object):void
		{
			super.onTweenEnd(value);
			
			// clean
			UIComponent(target).mx_internal::removeOverlay();
			
			uiTarget.setStyle("backgroundAlpha", this._preBackgroundAlpha);
			for (var i:int = 0; i < uiTarget.numChildren; i++) {
				uiTarget.getChildAt(i).visible = true;
			}
			
			this._bitmapDataList = new Array();
			this._bdDrawList = new Array();
			
			// gc
			try {
				new LocalConnection().connect("justforgc");
				new LocalConnection().connect("justforgc");
			} catch (e:Error) { }
		}
	}
}
package org.hamster.ruleComponent
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.events.ResizeEvent;
	import mx.graphics.ImageSnapshot;
	
	import spark.components.Group;
	import spark.layouts.BasicLayout;
	
	public class RuleComponent extends Group
	{
		public static const FROM_TO_MODE:String = "FromToMode";
		public static const GAP_MODE:String = "GapMode";
		
		private var _isRedrawRules:Boolean = true;
		private var _isRedrawInteractive:Boolean = true;
		private var _interactiveLayer:UIComponent;
		private var _textSnapshotUtil:UITextField;
		private var _matrixUtil:Matrix;
		
		private var _xFrom:Number;
		private var _yFrom:Number;
		private var _xTo:Number;
		private var _yTo:Number;
		private var _xGap:Number;
		private var _yGap:Number;
		private var _xGapWidth:Number;
		private var _yGapWidth:Number;
		private var _ruleWidth:Number;
		private var _isShowCrossline:Boolean = true;
		private var _ruleMode:String = GAP_MODE;
		
		
		public function set xFrom(value:Number):void
		{
			if (this._xFrom != value) {
				this._xFrom = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get xFrom():Number
		{
			return this._xFrom;
		}
		
		public function set yFrom(value:Number):void
		{
			if (this._yFrom != value) {
				this._yFrom = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get yFrom():Number
		{
			return this._yFrom;
		}
		
		public function set xTo(value:Number):void
		{
			if (this._xTo != value) {
				this._xTo = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get xTo():Number
		{
			return this._xTo;
		}
		
		public function set yTo(value:Number):void
		{
			if (this._yTo != value) {
				this._yTo = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get yTo():Number
		{
			return this._yTo;
		}
		
		public function set xGap(value:Number):void
		{
			if (this._xGap != value) {
				this._xGap = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get xGap():Number
		{
			return this._xGap;
		}
		
		public function set yGap(value:Number):void
		{
			if (this._yGap != value) {
				this._yGap = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get yGap():Number
		{
			return this._yGap;
		}
		
		public function set xGapWidth(value:Number):void
		{
			if (this._xGapWidth != value) {
				this._xGapWidth = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get xGapWidth():Number
		{
			return this._xGapWidth;
		}
		
		public function set yGapWidth(value:Number):void
		{
			if (this._yGapWidth != value) {
				this._yGapWidth = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get yGapWidth():Number
		{
			return this._yGapWidth;
		}
		
		public function set ruleWidth(value:Number):void
		{
			if (this._ruleWidth != value) {
				this._ruleWidth = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get ruleWidth():Number
		{
			return this._ruleWidth;
		}
		
		public function set ruleMode(value:String):void
		{
			if (this._ruleMode != value) {
				this._ruleMode = value;
				this._isRedrawRules = true;
				this.invalidateDisplayList();
			}
		}
		
		public function get ruleMode():String
		{
			return this._ruleMode;
		}
		
		public function set isShowCrossline(value:Boolean):void
		{
			if (this._isShowCrossline != value) {
				this._isShowCrossline = value;
				this.invalidateDisplayList();
			}
		}
		
		public function get isShowCrossline():Boolean
		{
			return this._isShowCrossline;
		}
		
		public function switch2FromToMode(xFrom_:Number, yFrom_:Number, 
										  xTo_:Number, yTo_:Number, 
										  xGap_:Number, yGap_:Number):void
		{
			this._ruleMode = FROM_TO_MODE;
			this.xFrom = xFrom_;
			this.yFrom = yFrom_;
			this.xTo = xTo_;
			this.yTo = yTo_;
			this.xGap = xGap_;
			this.yGap = yGap_;
		}
		
		public function switch2GapMode(xFrom_:Number, yFrom_:Number, 
									   xGap_:Number, yGap_:Number, 
									   xGapWidth_:Number, yGapWidth_:Number):void
		{
			this._ruleMode = GAP_MODE;
			this.xFrom = xFrom_;
			this.yFrom = yFrom_;
			this.xGap = xGap_;
			this.yGap = yGap_;
			this.xGapWidth = xGapWidth_;
			this.yGapWidth = yGapWidth_;			
		}
		
		public function RuleComponent()
		{
			super();
			
		//	this.verticalScrollPolicy = "off";
		//	this.horizontalScrollPolicy = "off";
			_matrixUtil = new Matrix();
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			this.addEventListener(ResizeEvent.RESIZE, resizeHandler);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			this._interactiveLayer = new UIComponent();
			_interactiveLayer.percentHeight = 100;
			_interactiveLayer.percentWidth = 100;
			this.addElement(this._interactiveLayer);
			
			_textSnapshotUtil = new UITextField();
		}
		
		private function mouseMoveHandler(evt:MouseEvent):void
		{
			this._isRedrawInteractive = true;
			this.invalidateDisplayList();
		}
		
		private function resizeHandler(evt:ResizeEvent):void
		{
			this._isRedrawRules = true;
			this.invalidateDisplayList();
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			if (!this.initialized) {
				return;
			}
			
			if (isNaN(_ruleWidth) || _ruleWidth <= 20) {
				_ruleWidth = 20;
			}
			
			// draw base lines
			if (_isRedrawRules) {
				_isRedrawRules = false;
				redrawRules(this.graphics, uw, uh);
				
			}
			
			if (_isRedrawInteractive) {
				_isRedrawInteractive = false;
				redrawInteractiveLayer(this._interactiveLayer.graphics, uw, uh);
			}
		}
		
		private function redrawRules(g:Graphics, uw:Number, uh:Number):void
		{
			g.clear();
			
			g.beginFill(0xFFFFFF, 0.001);
			g.drawRect(0, 0, uw, uh);
			g.endFill();
			
			g.lineStyle(1, 0x000000, 0.15);
			g.drawRect(this._ruleWidth, 0, uw - this._ruleWidth, this._ruleWidth);
			g.drawRect(0, this._ruleWidth, this._ruleWidth, uh - this._ruleWidth);
			g.lineStyle(1, 0x000000, 2);
			g.moveTo(this._ruleWidth, this._ruleWidth);
			g.lineTo(uw,  this._ruleWidth);
			g.moveTo(this._ruleWidth, this._ruleWidth);
			g.lineTo(this._ruleWidth,  uh);
			
			
			g.lineStyle(1, 0x000000, 1);
			var xUnitCount:Number;
			var xDrawGap:Number;
			var yUnitCount:Number;
			var yDrawGap:Number;
			if (this._ruleMode == FROM_TO_MODE) {
				xUnitCount = Math.abs(this._xFrom - this._xTo) / this._xGap;
				xDrawGap = uw / xUnitCount;
				yUnitCount = Math.abs(this._yFrom - this._yTo) / this._yGap;
				yDrawGap = uh / yUnitCount;
				this._xGapWidth = xDrawGap;
				this._yGapWidth = yDrawGap;
			} else if (this._ruleMode == GAP_MODE) {
				xUnitCount = (uw - this._ruleWidth) / this._xGapWidth;
				xDrawGap = this._xGapWidth * 10;
				yUnitCount = (uh - this._ruleWidth) / this._yGapWidth;
				yDrawGap = this._yGapWidth * 10;
				this._xTo = this._xFrom + xUnitCount * this._xGap;
				this._yTo = this._yFrom + xUnitCount * this._yGap;
			}
			
			var xDrawSmallGap:Number = xDrawGap * 0.1;
			var yDrawSmallGap:Number = yDrawGap * 0.1;
			
			for (var i:int = 0; i < xUnitCount + 1; i++) {
				var startX:Number = xDrawGap * i + this._ruleWidth;
				
				var ii:int = 0;
				var tmpX:Number = 0;
				if (startX > uw) {
					break;
				}
				g.moveTo(startX, 6);
				g.lineTo(startX, this._ruleWidth);
				
				// draw numbers
				var tipValue:Number = this._xGap * i + this._xFrom;
				_textSnapshotUtil.text = tipValue.toString();
				_textSnapshotUtil.width = _textSnapshotUtil.textWidth + 4;
				var textBitmapData:BitmapData = ImageSnapshot.captureBitmapData(_textSnapshotUtil);
				g.lineStyle(0, 0, 0);
				_matrixUtil.tx = startX + 1;
				_matrixUtil.ty = -2;
				g.beginBitmapFill(textBitmapData, _matrixUtil);
				g.drawRect(startX + 1, -2, _textSnapshotUtil.measuredWidth, _textSnapshotUtil.measuredHeight);
				g.endFill();
				g.lineStyle(1, 0x000000, 1);
				
				for (ii = 1; ii < 10; ii = ii + 2) {
					tmpX = startX + xDrawSmallGap * ii;
					if (tmpX > uw) {
						break;
					}
					g.moveTo(tmpX, this._ruleWidth - 4);
					g.lineTo(tmpX, this._ruleWidth);
				}
				
				for (ii = 2; ii < 10; ii = ii + 2) {
					tmpX = startX + xDrawSmallGap * ii;
					if (tmpX > uw) {
						break;
					}
					g.moveTo(tmpX, this._ruleWidth - 8);
					g.lineTo(tmpX, this._ruleWidth);
				}
			}
			
			for (var j:int = 0; j < yUnitCount + 1; j++) {
				var startY:Number = yDrawGap * j + this._ruleWidth;
				
				var jj:int = 0;
				var tmpY:Number = 0;
				if (startY > uh) {
					break;
				}
				g.moveTo(6, startY);
				g.lineTo(this._ruleWidth, startY);
				
				for (jj = 1; jj < 10; jj = jj + 2) {
					tmpY = startY + yDrawSmallGap * jj;
					if (tmpY > uh) {
						break;
					}
					g.moveTo(this._ruleWidth - 4, tmpY);
					g.lineTo(this._ruleWidth, tmpY);
				}
				
				for (jj = 2; jj < 10; jj = jj + 2) {
					tmpY = startY + yDrawSmallGap * jj;
					if (tmpY > uh) {
						break;
					}
					g.moveTo(this._ruleWidth - 8, tmpY);
					g.lineTo(this._ruleWidth, tmpY);
				}
			}
		}
		
		private function redrawInteractiveLayer(g:Graphics, uw:Number, uh:Number):void
		{
			g.clear();
			g.lineStyle(1, 0x000000, 1);
			// draw triangles
			var mx:Number = this.mouseX;
			var my:Number = this.mouseY;
			
			if (mx <= _ruleWidth) mx = _ruleWidth;
			if (mx > uw) mx = uw;
			if (my <= _ruleWidth) my = _ruleWidth;
			if (my > uh) my = uh;
			
			var h:Number = this._ruleWidth * 0.3;
			var ruleWidMinusH:Number = this._ruleWidth - h;
			g.beginFill(0x000000, 1);
			g.moveTo(mx, this._ruleWidth);
			g.lineTo(mx - h, ruleWidMinusH);
			g.lineTo(mx + h, ruleWidMinusH);
			g.moveTo(mx, this._ruleWidth);
			
			g.moveTo(this._ruleWidth, my);
			g.lineTo(ruleWidMinusH, my - h);
			g.lineTo(ruleWidMinusH, my + h);
			g.lineTo(this._ruleWidth, my);
			g.endFill();
			
			// draw crosslines
			if (this.isShowCrossline) {
				g.lineStyle(1, 0x99D9EA);
				g.moveTo(_ruleWidth, my);
				g.lineTo(uw, my);
				
				g.moveTo(mx, _ruleWidth);
				g.lineTo(mx, uh);
			}
		}
	}
}
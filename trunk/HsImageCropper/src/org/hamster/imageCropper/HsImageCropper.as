package org.hamster.imageCropper
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	import mx.managers.CursorManager;
	
	[Event(name="mDown", type="org.hamster.imageCropper.HsImageCropperEvent")]
	[Event(name="mUp", type="org.hamster.imageCropper.HsImageCropperEvent")]
	[Event(name="selectionChange", type="org.hamster.imageCropper.HsImageCropperEvent")]
	[Event(name="sourceChange", type="org.hamster.imageCropper.HsImageCropperEvent")]
	
	public class HsImageCropper extends Canvas
	{
		private static const TOP:uint     =  1;   //  000001
		private static const LEFT:uint    =  2;   //  000010
		private static const BOTTOM:uint  =  4;   //  000100
		private static const RIGHT:uint   =  8;   //  001000
		private static const CENTER:uint  = 16;   //  010000
		private static const MIDDLE:uint  = 32;   //  100000
		private static const MOVE:uint    = 64;   // 1000000
		
		[Embed(source='/org/hamster/imageCropper/assets/resize_lt_rb.png')]
		private static var CURSOR_LT_RB:Class;
		[Embed(source='/org/hamster/imageCropper/assets/resize_rt_lb.png')]
		private static var CURSOR_RT_LB:Class;
		[Embed(source='/org/hamster/imageCropper/assets/resize_ct_cb.png')]
		private static var CURSOR_CT_CB:Class;
		[Embed(source='/org/hamster/imageCropper/assets/resize_lm_rm.png')]
		private static var CURSOR_LM_RM:Class;
		[Embed(source='/org/hamster/imageCropper/assets/resize_move.png')]
		private static var CURSOR_MOVE:Class;
		
		private const _mainImage:Image = new Image();
		private var _selectMask:UIComponent;
		
		private var _mouseDown:Boolean;
		private var _originX:Number;
		private var _originY:Number;
		private var _location:uint;
		private var _moveLoc:uint;
		
		private var _boundArea:Rectangle = new Rectangle();
		private var _oldArea:Rectangle = new Rectangle();
		
		private var _blockWidth:Number = 8;
		private var _maintainAspectRatio:Boolean;
		private var _selectedArea:Rectangle = new Rectangle();
		private var _minSelectionH:Number = 20;
		private var _minSelectionW:Number = 20;
		
		private var _cursorLT:Class = CURSOR_LT_RB;
		private var _cursorCT:Class = CURSOR_CT_CB;
		private var _cursorRT:Class = CURSOR_RT_LB;
		private var _cursorLM:Class = CURSOR_LM_RM;
		private var _cursorRM:Class = CURSOR_LM_RM;
		private var _cursorLB:Class = CURSOR_RT_LB;
		private var _cursorCB:Class = CURSOR_CT_CB;
		private var _cursorRB:Class = CURSOR_LT_RB;
		private var _cursorMV:Class = CURSOR_MOVE;
		private var _cursorOffset:Number = -13;
		
		public function set blockWidth(value:Number):void
		{ 
			if (_blockWidth != value) {
				_blockWidth = value;
				invalidateDisplayList();
			}
		}
		public function get blockWidth():Number { return _blockWidth }
		public function set source(value:Object):void 
		{
			if (this._mainImage.source != value) {
				this._mainImage.source = value;
				invalidateDisplayList();
				dispatchICEvent(HsImageCropperEvent.SOURCE_CHANGE, -1, -1);
			}
		}
		public function get source():Object { return this._mainImage.source }
		
		public function get content():Object { return this._mainImage.content }
		public function set maintainAspectRatio(value:Boolean):void 
		{
			if (_maintainAspectRatio != value) {
				_maintainAspectRatio = value;
				invalidateDisplayList();
			}
		}
		public function get maintainAspectRatio():Boolean { return _maintainAspectRatio }
		public function set selectedArea(value:Rectangle):void
		{
			if (_selectedArea != value) {
				_selectedArea = value;
				invalidateDisplayList();
			}
		}
		public function get selectedArea():Rectangle { return _selectedArea; }
		public function set cropArea(value:Rectangle):void
		{
			if (_mainImage.source != null) {
				var p:Number =  _boundArea.width / _mainImage.content.width;
				_selectedArea.x = value.x * p;
				_selectedArea.y = value.y * p;
				_selectedArea.width = value.width * p;
				_selectedArea.height = value.height * p;
				invalidateDisplayList();
			}
		}
		public function get cropArea():Rectangle
		{
			if (_mainImage.source != null) {
				var p:Number = _mainImage.content.width / _boundArea.width;
				var result:Rectangle = new Rectangle();
				result.x = (_selectedArea.x - _boundArea.x) * p;
				result.y = (_selectedArea.y - _boundArea.y) * p;
				result.width = _selectedArea.width * p;
				result.height = _selectedArea.height * p;
				return result;
			} else {
				return null;
			}
		}
		public function set minSelectionH(value:Number):void 
		{ 
			if (_minSelectionH != value) {
				_minSelectionH = Math.max(1, value);
				invalidateDisplayList();
			}
		}
		public function get minSelectionH():Number { return _minSelectionH }
		public function set minSelectionW(value:Number):void 
		{
			if (_minSelectionW != value) {
				_minSelectionW = Math.max(1, value);
				invalidateDisplayList();
			}
		}
		public function get minSelectionW():Number { return _minSelectionW }
		
		public function set cursorLT(value:Class):void { _cursorLT = value }
		public function set cursorCT(value:Class):void { _cursorCT = value }
		public function set cursorRT(value:Class):void { _cursorRT = value }
		public function set cursorLM(value:Class):void { _cursorLM = value }
		public function set cursorRM(value:Class):void { _cursorRM = value }
		public function set cursorLB(value:Class):void { _cursorLB = value }
		public function set cursorCB(value:Class):void { _cursorCB = value }
		public function set cursorRB(value:Class):void { _cursorRB = value }
		public function set cursorMV(value:Class):void { _cursorMV = value }
		
		public function HsImageCropper()
		{
			super();
		}
		
		private function imageSetCompleteHandler(evt:Event):void
		{
			if (!this.initialized) {
				this.callLater(initBoundArea);
				return;
			}
			initBoundArea();
		}
		
		private function imgResizeHandler(evt:ResizeEvent):void
		{
			if (_mainImage.source) {
				initBoundArea();
			}
		}
		
		private function initBoundArea():void
		{
			var cw:Number = this._mainImage.contentWidth;
			var ch:Number = this._mainImage.contentHeight;
			if (isNaN(cw) || isNaN(ch) || cw == 0 || ch == 0) return;
			var ratio1:Number = cw / ch;
			var ratio2:Number = this.width / this.height;
			if (ratio1 > ratio2) {
				_boundArea.x = 0;
				_boundArea.width = this.width;
				_boundArea.height = this.width / ratio1;
				_boundArea.y = (this.height - _boundArea.height) / 2;
			} else {
				_boundArea.y = 0;
				_boundArea.height = this.height;
				_boundArea.width = this.height * ratio1;
				_boundArea.x = (this.width - _boundArea.width) / 2;
			}
			
			_selectedArea.x = _boundArea.x + _boundArea.width / 4;
			_selectedArea.y = _boundArea.y + _boundArea.height / 4;
			_selectedArea.width = _boundArea.width / 2;
			_selectedArea.height = _boundArea.height / 2;
			this.invalidateDisplayList();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_mainImage.percentWidth = 100;
			_mainImage.percentHeight = 100;
			_mainImage.addEventListener(Event.COMPLETE, imageSetCompleteHandler);
			_mainImage.addEventListener(ResizeEvent.RESIZE, imgResizeHandler);
			_mainImage.setStyle("verticalAlign", "middle");
			_mainImage.setStyle("horizontalAlign", "center");
			this.addChild(_mainImage);
			
			_selectMask = new UIComponent();
			_selectMask.percentWidth = 100;
			_selectMask.percentHeight = 100;
			_selectMask.addEventListener(MouseEvent.MOUSE_DOWN, maskMouseDownHandler);
			_selectMask.addEventListener(MouseEvent.MOUSE_MOVE, maskMouseMoveHandler);
			_selectMask.addEventListener(MouseEvent.MOUSE_UP,   maskMouseUpHandler);
			_selectMask.addEventListener(MouseEvent.MOUSE_OUT,  maskRollOutHandler);
			this.addChild(_selectMask);
		}
		
		override protected function measure():void
		{
			super.measure();
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			var sx:Number = _selectedArea.x;
			var sy:Number = _selectedArea.y;
			var sw:Number = _selectedArea.width;
			var sh:Number = _selectedArea.height;
			
			// draw mask
			var g:Graphics = this._selectMask.graphics;
			g.clear();
			g.beginFill(0x000000, 0.3);
			g.drawRect(0, 0, uw, uh);
			g.drawRect(sx, sy, sw, sh);
			g.endFill();
			
			g.beginFill(0x000000, 0.01);
			g.drawRect(sx, sy, sw, sh);
			g.endFill();
			
			// draw corners
			drawSelectedAreaCorner(g, sx, sy);
			drawSelectedAreaCorner(g, sx, sy + sh);
			drawSelectedAreaCorner(g, sx + sw, sy);
			drawSelectedAreaCorner(g, sx + sw, sy + sh);
			
			if (!maintainAspectRatio) {
				drawSelectedAreaCorner(g, sx, sy + sh / 2);
				drawSelectedAreaCorner(g, sx + sw / 2, sy);
				drawSelectedAreaCorner(g, sx + sw / 2, sy + sh);
				drawSelectedAreaCorner(g, sx + sw, sy + sh / 2);
			}
			
			// 
			drawSelectedAreaBorder(g, _selectedArea);
			
		}
		
		private function maskMouseDownHandler(evt:MouseEvent):void
		{
			_mouseDown = true;
			_originX = evt.localX;
			_originY = evt.localY;
			
			_location = refreshLocation(_originX, _originY);
			
			var count:int = 2;
			
			if (_location & LEFT) {
				count--;
				_originX = _selectedArea.x;
			} else if (_location & CENTER) {
				count--;
				_originX = _selectedArea.x + _selectedArea.width / 2;
			} else if (_location & RIGHT) {
				count--;
				_originX = _selectedArea.x + _selectedArea.width;
			}
			
			if (_location & TOP) {
				count--;
				_originY = _selectedArea.y;
			} else if (_location & MIDDLE) {
				count--;
				_originY = _selectedArea.y + _selectedArea.height / 2;
			} else if (_location & BOTTOM) {
				count--;
				_originY = _selectedArea.y + _selectedArea.height;
			}
			
			_oldArea = _selectedArea.clone();
			
			this.invalidateDisplayList();
			
			dispatchICEvent(HsImageCropperEvent.M_DOWN, evt.localX, evt.localY);
		}
		
		private function maskMouseMoveHandler(evt:MouseEvent):void
		{
			if (_mouseDown && evt.buttonDown) {
				// change location
				var offsetX:Number = evt.localX - _originX;
				var offsetY:Number = evt.localY - _originY;
				
				if (_location != MOVE) {
					if (_location & LEFT) {
						_selectedArea.width = _oldArea.width - offsetX;
						if (_selectedArea.width > this._minSelectionW) {
							_selectedArea.x = _oldArea.x + offsetX;
						}
					} else if (_location & RIGHT) {
						_selectedArea.width = _oldArea.width + offsetX;
					}
					
					if (_location & TOP) {
						_selectedArea.height = _oldArea.height - offsetY;
						if (_selectedArea.height > this._minSelectionH) {
							_selectedArea.y = _oldArea.y + offsetY;
						}
					} else if (_location & BOTTOM) {
						_selectedArea.height = _oldArea.height + offsetY;
					}
				} else {
					// move
					_selectedArea.x = _oldArea.x + offsetX;
					_selectedArea.y = _oldArea.y + offsetY;
				}
				
				if (maintainAspectRatio && _location != 0 && _location != MOVE) {
					var r1:Number = _selectedArea.width / _selectedArea.height;
					var r2:Number = _boundArea.width / _boundArea.height;
					
					if (r1 > r2 && _selectedArea.width > this._minSelectionW) {
						var measuredW:Number = _selectedArea.height * r2;
						if (_location & LEFT) {
							_selectedArea.x += _selectedArea.width - measuredW;
						}
						_selectedArea.width = measuredW;
					} else {
						var measuredH:Number = _selectedArea.width / r2;
						if (_location & TOP && _selectedArea.height > this._minSelectionH) {
							_selectedArea.y += _selectedArea.height - measuredH;
						}
						_selectedArea.height = measuredH;
					}
				}
				isOutOfBound();
				this.invalidateDisplayList();
				dispatchICEvent(HsImageCropperEvent.SELECTION_CHANGE, evt.localX, evt.localY);
			} else {
				// just update cursor
				var _tempMoveLoc:uint = refreshLocation(evt.localX, evt.localY);
				if (_moveLoc != 0 && _tempMoveLoc == 0
					&& !_selectedArea.contains(evt.localX, evt.localY)) {
					hideResizeCursor();
					_moveLoc = 0;
				} else if (_tempMoveLoc != _moveLoc) {
					if (_moveLoc == 0) {
						showResizeCursor(_tempMoveLoc);
						_moveLoc = _tempMoveLoc;
					} else if (_tempMoveLoc != 0) {
						hideResizeCursor();
						showResizeCursor(_tempMoveLoc);
						_moveLoc = _tempMoveLoc;
					}
				}
			}
		}
		
		private function maskMouseUpHandler(evt:MouseEvent):void
		{
			this._mouseDown = false;
			dispatchICEvent(HsImageCropperEvent.M_UP, evt.localX, evt.localY);
//			_location = 0;
//			this.hideResizeCursor();
//			this._moveLoc = 0;
		}
		
		private function maskRollOutHandler(evt:MouseEvent):void
		{
			if (this._mouseDown == false) {
				hideResizeCursor();
			}
		}
		
		private function refreshLocation(px:Number, py:Number):uint
		{
			var _sx:Number = this._selectedArea.x;
			var _sy:Number = this._selectedArea.y;
			var _sw:Number = this._selectedArea.width;
			var _sh:Number = this._selectedArea.height;
			var _bw:Number = this.blockWidth;
			
			var loc:uint = 0;
			
			var _isX:Boolean = false;
			var _isY:Boolean = false;
			// count X
			if (px < _sx + _bw && px > _sx - _bw) {
				loc = loc | LEFT;
				_isX = true;
			} else if (px < _sx + _bw + _sw / 2 && px > _sx - _bw + _sw / 2) {
				loc = loc | CENTER;
				_isX = true;
			} else if (px < _sx + _bw + _sw && px > _sx - _bw + _sw) {
				loc = loc | RIGHT;
				_isX = true;
			}
			
			// count Y
			if (py < _sy + _bw && py > _sy - _bw) {
				loc = loc | TOP;
				_isY = true;
			} else if (py < _sy + _bw + _sh / 2  && py > _sy - _bw + _sh / 2) {
				loc = loc | MIDDLE;
				_isY = true;
			} else if (py < _sy + _bw + _sh  && py > _sy - _bw + _sh) {
				loc = loc | BOTTOM;
				_isY = true;
			}
			
			if ((loc == (CENTER | MIDDLE)) 
				|| (!(_isX && _isY) && _selectedArea.contains(px, py))) {
				return MOVE;
			}
			if (_isX && _isY) {
				return loc;	
			} else {
				return 0;
			}
		}
		
		private function isOutOfBound():void
		{
			var deltaX:Number = _selectedArea.x - _boundArea.x;
			var deltaY:Number = _selectedArea.y - _boundArea.y;
			var deltaW:Number = _selectedArea.width - _boundArea.width;
			var deltaH:Number = _selectedArea.height - _boundArea.height;
			
			if (_selectedArea.x < _boundArea.x) {
				if (_location & LEFT) {
					_selectedArea.width += deltaX;
				}
				_selectedArea.x = _boundArea.x;
			}
			if (_selectedArea.y < _boundArea.y) {
				if (_location & TOP) {
					_selectedArea.height += deltaY;
				}
				_selectedArea.y = _boundArea.y;
			}
			if (_selectedArea.x + _selectedArea.width > _boundArea.width + _boundArea.x) {
				if (_location & RIGHT) {
					_selectedArea.width -= (deltaX + deltaW);
				} else {
					_selectedArea.x = _boundArea.width - _selectedArea.width + _boundArea.x;
				}
			}
			if (_selectedArea.y + _selectedArea.height > _boundArea.height + _boundArea.y) {
				if (_location & BOTTOM) {
					_selectedArea.height -= (deltaY + deltaH);
				} else {
					_selectedArea.y = _boundArea.height - _selectedArea.height + _boundArea.y;
				}
			}
			
			if (_selectedArea.height < this._minSelectionH) {
				if (_mouseDown && (_location & TOP)) {
					_selectedArea.y = _oldArea.y + _oldArea.height - this.minSelectionH;
				}
				_selectedArea.height = this._minSelectionH;
			}
			if (_selectedArea.width < this._minSelectionW) {
				if (_mouseDown && (_location & LEFT)) {
					_selectedArea.x = _oldArea.x + _oldArea.width - this.minSelectionW;
				}
				_selectedArea.width = this._minSelectionW;
			}
		}
		
		private function showResizeCursor(location:uint):Boolean
		{
			if (location == (LEFT | TOP)) {
				CursorManager.setCursor(_cursorLT, 2, _cursorOffset, _cursorOffset);
				return true;
			} else if (location == (CENTER | TOP) && !maintainAspectRatio) {
				CursorManager.setCursor(_cursorCT, 2, _cursorOffset, _cursorOffset);
				return true;
			} else if (location == (RIGHT | TOP)) {
				CursorManager.setCursor(_cursorRT, 2, _cursorOffset, _cursorOffset);
				return true;
			} else if (location == (LEFT | MIDDLE) && !maintainAspectRatio) {
				CursorManager.setCursor(_cursorLM, 2, _cursorOffset, _cursorOffset);
				return true;
			} else if (location == (RIGHT | MIDDLE) && !maintainAspectRatio) {
				CursorManager.setCursor(_cursorRM, 2, _cursorOffset, _cursorOffset);
				return true;
			} else if (location == (LEFT | BOTTOM)) {
				CursorManager.setCursor(_cursorLB, 2, _cursorOffset, _cursorOffset);
				return true;
			} else if (location == (CENTER | BOTTOM) && !maintainAspectRatio) {
				CursorManager.setCursor(_cursorCB, 2, _cursorOffset, _cursorOffset);
				return true;
			} else if (location == (RIGHT | BOTTOM)) {
				CursorManager.setCursor(_cursorRB, 2, _cursorOffset, _cursorOffset);
				return true;
			} else if (location == MOVE) {
				CursorManager.setCursor(_cursorMV, 2, _cursorOffset, _cursorOffset);
				return true;
			}
			return false;
		}
		
		private function hideResizeCursor():void
		{
			CursorManager.removeAllCursors();
		}
		
		protected function drawSelectedAreaCorner(g:Graphics, centerX:Number, centerY:Number):void
		{
			g.lineStyle(1, 0xEAEAEA);
			g.drawRect(centerX - blockWidth / 2, centerY - blockWidth / 2, blockWidth, blockWidth);
		}
		
		protected function drawSelectedAreaBorder(g:Graphics, sArea:Rectangle):void
		{
			var sx:Number = _selectedArea.x;
			var sy:Number = _selectedArea.y;
			var sw:Number = _selectedArea.width;
			var sh:Number = _selectedArea.height;
			
			var gap:Number = 5;
			var t_gap:Number = 10;
			
			g.lineStyle(1, 0xEAEAEA);
			// top & bottom
			var offset:Number = 0;
			for (; offset < sw - gap; offset += t_gap) {
				g.moveTo(offset + sx, sy);
				g.lineTo(offset + sx + gap, sy);
				g.moveTo(offset + sx, sy + sh);
				g.lineTo(offset + sx + gap, sy + sh);
			}
			if (sw > offset) {
				g.moveTo(offset + sx, sy);
				g.lineTo(sx + sw, sy);
				g.moveTo(offset + sx, sy + sh);
				g.lineTo(sx + sw, sy + sh);
			}
			
			// left & right
			offset = 0;
			for (; offset < sh - gap; offset += t_gap) {
				g.moveTo(sx, sy + offset);
				g.lineTo(sx, sy + offset + gap);
				g.moveTo(sx + sw, sy + offset);
				g.lineTo(sx + sw, sy + offset + gap);
			}
			if (sh > offset) {
				g.moveTo(sx, sy + offset);
				g.lineTo(sx, sy + sh);
				g.moveTo(sx + sw, sy + offset);
				g.lineTo(sx + sw, sy + sh);
			}
		}
		
		private function dispatchICEvent(type:String, x:Number, y:Number):void
		{
			if (hasEventListener(type)) {
				var disEvt:HsImageCropperEvent = new HsImageCropperEvent(type);
				disEvt.mouseX = x;
				disEvt.mouseY = y;
				disEvt.cropArea = cropArea ? cropArea.clone() : new Rectangle(-1, -1, -1, -1);
				this.dispatchEvent(disEvt);
			}
		}
		
	}
}

﻿
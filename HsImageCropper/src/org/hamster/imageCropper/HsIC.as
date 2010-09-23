package org.hamster.imageCropper
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.UIComponent;
	
	public class HsIC extends Canvas
	{
		private static const TOP:uint     =  1;   //  000001
		private static const LEFT:uint    =  2;   //  000010
		private static const BOTTOM:uint  =  4;   //  000100
		private static const RIGHT:uint   =  8;   //  001000
		private static const CENTER:uint  = 16;   //  010000
		private static const MIDDLE:uint  = 32;   //  100000
		private static const MOVE:uint    = 64;   // 1000000
		
		
		private const _mainImage:Image = new Image();
		private var _selectMask:UIComponent;
		
		private var _mouseDown:Boolean;
		private var _originX:Number;
		private var _originY:Number;
		private var _location:uint;
		
		private var _minSelectionH:Number = 20;
		private var _minSelectionW:Number = 20;
		private var _boundArea:Rectangle = new Rectangle();
		
		private var _selectedArea:Rectangle = new Rectangle();
		private var _oldArea:Rectangle = new Rectangle();
		
		private var _blockWidth:Number = 8;
		private var _maintainAspectRatio:Boolean;
		
		public function set blockWidth(value:Number):void { _blockWidth = value }
		public function get blockWidth():Number { return _blockWidth }
		public function set source(value:Object):void { this._mainImage.source = value }
		public function get source():Object { return this._mainImage.source }
		public function set maintainAspectRatio(value:Boolean):void { _maintainAspectRatio = value }
		public function get maintainAspectRatio():Boolean { return _maintainAspectRatio }
		
		public function set selectedArea(value:Rectangle):void
		{
			_selectedArea = value;
			this.invalidateDisplayList();
		}
		public function get selectedArea():Rectangle { return _selectedArea }
		
		
		
		public function HsIC()
		{
			super();
		}
		
		private function imageSetCompleteHandler(evt:Event):void
		{
			if (!this.initialized) {
				this.callLater(imageSetCompleteHandler, [evt]);
				return;
			}
			var cw:Number = this._mainImage.contentWidth;
			var ch:Number = this._mainImage.contentHeight;
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
			_mainImage.setStyle("verticalAlign", "middle");
			_mainImage.setStyle("horizontalAlign", "center");
			this.addChild(_mainImage);
			
			_selectMask = new UIComponent();
			_selectMask.percentWidth = 100;
			_selectMask.percentHeight = 100;
			_selectMask.addEventListener(MouseEvent.MOUSE_DOWN, maskMouseDownHandler);
			_selectMask.addEventListener(MouseEvent.MOUSE_MOVE, maskMouseMoveHandler);
			_selectMask.addEventListener(MouseEvent.MOUSE_UP,   maskMouseUpHandler);
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
			
		}
		
		private function maskMouseDownHandler(evt:MouseEvent):void
		{
			_mouseDown = true;
			_originX = evt.localX;
			_originY = evt.localY;
			
			refreshLocation(_originX, _originY);
			
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
			
			if (count > 0 || (_location == (MIDDLE | CENTER))) {
				_location = MOVE;
			}// else location is the selected action
			
			_oldArea = _selectedArea.clone();
			
			this.invalidateDisplayList();
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
				isOutOfBound();
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
			} else {
				// just update cursor
			}
			
			
			this.invalidateDisplayList();
		}
		
		private function maskMouseUpHandler(evt:MouseEvent):void
		{
			this._mouseDown = false;
		}
		
		private function refreshLocation(px:Number, py:Number):void
		{
			var _sx:Number = this._selectedArea.x;
			var _sy:Number = this._selectedArea.y;
			var _sw:Number = this._selectedArea.width;
			var _sh:Number = this._selectedArea.height;
			var _bw:Number = this.blockWidth;
			
			_location = 0;
			
			// count X
			if (px < _sx + _bw && px > _sx - _bw) {
				_location = _location | LEFT;
			} else if (px < _sx + _bw + _sw / 2 && px > _sx - _bw + _sw / 2) {
				_location = _location | CENTER;
			} else if (px < _sx + _bw + _sw && px > _sx - _bw + _sw) {
				_location = _location | RIGHT;
			}
			
			// count Y
			if (py < _sy + _bw && py > _sy - _bw) {
				_location = _location | TOP;
			} else if (py < _sy + _bw + _sh / 2  && py > _sy - _bw + _sh / 2) {
				_location = _location | MIDDLE;
			} else if (py < _sy + _bw + _sh  && py > _sy - _bw + _sh) {
				_location = _location | BOTTOM;
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
				_selectedArea.height = this._minSelectionH;
			}
			if (_selectedArea.width < this._minSelectionW) {
				_selectedArea.width = this._minSelectionW;
			}
		}
		
		protected function drawSelectedAreaCorner(g:Graphics, centerX:Number, centerY:Number):void
		{
			g.lineStyle(1, 0x7f7f7f);
			g.drawRect(centerX - blockWidth / 2, centerY - blockWidth / 2, blockWidth, blockWidth);
		}
		
		protected function drawSelectedAreaBorder(g:Graphics, sArea:Rectangle):void
		{
			
		}
		
		
	}
}

﻿
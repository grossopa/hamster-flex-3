package org.hamster.magic.common.models
{
	import org.hamster.magic.common.events.MagicEvent;
	import org.hamster.magic.common.models.base.AbstractModelSupport;
	import org.hamster.magic.common.utils.Constants;
	
	[Event(name="change", type="org.hamster.magic.common.events.MagicEvent")]
	[Event(name="multiChange", type="org.hamster.magic.common.events.MagicEvent")]
	
	public class Magic extends AbstractModelSupport
	{
		private var _red:int;
		private var _blue:int;
		private var _green:int;
		private var _black:int;
		private var _white:int;
		private var _colorless:int;
		
		public function gt(bMagic:Magic):Boolean
		{
			var tRed:int = this.red - bMagic.red;
			var tBlue:int = this.blue - bMagic.blue;
			var tGreen:int = this.green - bMagic.green;
			var tBlack:int = this.black - bMagic.black;
			var tWhite:int = this.white - bMagic.white;
			if (tRed < 0 || tBlue < 0 
					|| tGreen < 0 || tBlack < 0 || tWhite < 0) {
				return false;
			}
			var tColorless:int = this.colorless - bMagic.colorless 
					+ tRed + tBlue + tGreen + tBlack + tWhite;
			return tColorless >= 0;
		}
		
		public function minus(bMagic:Magic):void
		{
			this.minusNumber(bMagic.red, bMagic.blue, bMagic.green, 
				bMagic.black, bMagic.white, bMagic.colorless);
		}
		
		public function minusNumber(r:int, b:int, g:int, blk:int, w:int, c:int):void
		{
			this.setNumber(this._red - r, this._blue - b, this._green - g, 
				this._black - blk, this._white - w, this._colorless - c);
		}
		
		public function setNumber(r:int, b:int, g:int, blk:int, w:int, c:int):void
		{
			var colors:Array = new Array();
			var oldValues:Array = new Array();
			var newValues:Array = new Array();
			
			if (r != this._red) {
				colors.push(Constants.RED);
				oldValues.push(this._red);
				this._red = r;
				newValues.push(this._red);
			}
			if (b != this._blue) {
				colors.push(Constants.BLUE);
				oldValues.push(this._blue);
				this._blue = b;
				newValues.push(this._blue);
			}
			if (g != this._green) {
				colors.push(Constants.GREEN);
				oldValues.push(this._green);
				this._green = g;
				newValues.push(this._green);
			}
			if (blk != this._black) {
				colors.push(Constants.BLACK);
				oldValues.push(this._black);
				this._black = blk;
				newValues.push(this._black);
			}
			if (w != this._white) {
				colors.push(Constants.WHITE);
				oldValues.push(this._white);
				this._white = w;
				newValues.push(this._white);
			}
			if (c != this._colorless) {
				colors.push(Constants.COLORLESS);
				oldValues.push(this._colorless);
				this._colorless = c;
				newValues.push(this._colorless);
			}
			
			if (colors.length > 0) {
				var disEvt:MagicEvent = new MagicEvent(MagicEvent.MULTI_CHANGE);
				disEvt.colors = colors;
				disEvt.oldValues = oldValues;
				disEvt.newValues = newValues;
				this.dispatchEvent(disEvt);
			}			
		}
		
		public function clear():void
		{
			this.setNumber(0,0,0,0,0,0);
		}
		
		public function decodeString(str:String):void
		{
			if (str != null && str.length != 0) {
				var arr:Array = str.split(",");
				red = arr[0];
				blue = arr[1];
				green = arr[2];
				black = arr[3];
				white = arr[4];
				colorless = arr[5];
			}
		}
		
		public function encodeString():String
		{
			return red + "," + blue + "," + green + "," 
					+ black + "," + white + "," + colorless;
		}
		
		public function get allCount():int
		{
			return red + blue + green + black + white + colorless;
		}
		
		public function clone():Magic
		{
			var result:Magic = new Magic();
			result.setNumber(this._red, this._blue, 
				this._green, this._black, 
				this._white, this._colorless);
			return result;
		}
		
		public function set red(value:int):void
		{
			if (value != this.red) {
				this._red = value < 0 ? 0 : value;
				dispatchChangeEvent(this.red, value, Constants.RED);
			}
		}
		
		public function get red():int
		{
			return this._red;
		}
		
		public function set blue(value:int):void
		{
			if (value != this.blue) {
				this._blue = value < 0 ? 0 : value;
				dispatchChangeEvent(this.blue, value, Constants.BLUE);
			}
		}
		
		public function get blue():int
		{
			return this._blue;
		}
		
		public function set green(value:int):void
		{
			if (value != this.green) {
				this._green = value < 0 ? 0 : value;
				dispatchChangeEvent(this.green, value, Constants.GREEN);
			}
		}
		
		public function get green():int
		{
			return this._green;
		}
		
		public function set black(value:int):void
		{
			if (value != this.black) {
				this._black = value < 0 ? 0 : value;
				dispatchChangeEvent(this.black, value, Constants.BLACK);
			}
		}
		
		public function get black():int
		{
			return this._black;
		}
		
		public function set white(value:int):void
		{
			if (value != this.white) {
				this._white = value < 0 ? 0 : value;
				dispatchChangeEvent(this.white, value, Constants.WHITE);
			}
		}
		
		public function get white():int
		{
			return this._white;
		}
		
		public function set colorless(value:int):void
		{
			if (value != this.colorless) {
				this._colorless = value < 0 ? 0 : value;
				dispatchChangeEvent(this.colorless, value, Constants.COLORLESS);
			}
		}
		
		public function get colorless():int
		{
			return this._colorless;
		}
		
		private function dispatchChangeEvent(oldValue:int, newValue:int, color:String):void
		{
			var magicEvent:MagicEvent = new MagicEvent(MagicEvent.CHANGE);
			magicEvent.color = color;
			magicEvent.oldValue = oldValue;
			magicEvent.newValue = newValue;
			this.dispatchEvent(magicEvent);
		}

	}
}
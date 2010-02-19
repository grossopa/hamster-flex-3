package org.hamster.magic.common.models
{
	import org.hamster.magic.common.events.MagicEvent;
	import org.hamster.magic.common.models.base.AbstractModelSupport;
	import org.hamster.magic.common.utils.Constants;
	
	[Event(name="change", type="org.hamster.magic.common.events.MagicEvent")]
	
	public class Magic extends AbstractModelSupport
	{
		private var _red:int;
		private var _blue:int;
		private var _green:int;
		private var _black:int;
		private var _white:int;
		private var _colorless:int;
		
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
			result.red = this.red;
			result.blue = this.blue;
			result.green = this.green;
			result.black = this.black;
			result.white = this.white;
			result.colorless = this.colorless;
			return result;
		}
		
		public function set red(value:int):void
		{
			if (value != this.red) {
				this._red = value;
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
				this._blue = value;
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
				this._green = value;
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
				this._black = value;
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
				this._white = value;
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
				this._colorless = value;
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
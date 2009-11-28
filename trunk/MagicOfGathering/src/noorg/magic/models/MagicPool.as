package noorg.magic.models
{
	public class MagicPool
	{
		public var red:int;
		public var blue:int;
		public var green:int;
		public var black:int;
		public var white:int;
		public var colorless:int;
		
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
		
		public function clone():MagicPool
		{
			var result:MagicPool = new MagicPool();
			result.red = this.red;
			result.blue = this.blue;
			result.green = this.green;
			result.black = this.black;
			result.white = this.white;
			result.colorless = this.colorless;
			return result;
		}

	}
}
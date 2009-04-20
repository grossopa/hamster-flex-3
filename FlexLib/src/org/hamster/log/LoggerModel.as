package org.hamster.log
{
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class LoggerModel
	{
		private const GAP_STR:String = " || ";
		public static var sequence:Array;
		
		public var time:String;
		public var level:String;
		public var className:String;
		public var mainString:String;
		
		public var color:String;
		
		public function toFormatString():String
		{
			var result:String = "";
			for each(var seq:int in sequence) {
				switch(seq) {
					case Logger.SEQ_TIME:
						result += this.time;
						break;
					case Logger.SEQ_LEVEL:
						result += this.level;
						break;
					case Logger.SEQ_STR:
						result += this.mainString;
						break;
					case Logger.SEQ_CLASS:
						result += this.className;
						break;
				}
				result += GAP_STR;
			}
			
			return result.substr(0, result.length - GAP_STR.length);			
		}
		

	}
}
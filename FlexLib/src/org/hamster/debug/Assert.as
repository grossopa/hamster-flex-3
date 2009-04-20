package org.hamster.debug
{
	import mx.containers.VBox;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	public class Assert
	{
		public static function isTrue(obj:Boolean):void
		{
			if(!obj) throw new Error("assert isTrue failed.");
		}
		
		public static function isFalse(obj:Boolean):void
		{
			if(obj) throw new Error("assert isFalse failed.");
		}
		
		public static function notNull(obj:Object):void
		{
			if(obj == null) throw new Error("assert notNull failed.");
		}
		
		public static function isNull(obj:Object):void
		{
			if(obj != null) throw new Error("assert isNull failed.");
		}
		
	}
}
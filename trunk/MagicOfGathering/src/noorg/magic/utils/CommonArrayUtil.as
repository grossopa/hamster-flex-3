package noorg.magic.utils
{
	public class CommonArrayUtil
	{
		public static function generateIntegerArray(fromInt:int, toInt:int):Array
		{
			var source:Array = new Array();
			var length:int = toInt - fromInt + 1;
			for(var i:int = 0; i < length; i++) {  
				source[i] = i + fromInt;  
			}
			
			for(i = 0; i < length; i++) {  
				j = int(Math.random() * length);
				swapArray(source, i, j);
			}
			return source;
		}
		
		public static function swapArray(item:Array, index1:int, index2:int):void
		{
			var temp:Object = item[index1];
			item[index1] = item[index2];
			item[index2] = temp;
		}

	}
}
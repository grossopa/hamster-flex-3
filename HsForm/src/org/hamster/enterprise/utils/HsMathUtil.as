package org.hamster.enterprise.utils
{
	import mx.formatters.CurrencyFormatter;
	import mx.formatters.NumberBase;
	import mx.formatters.NumberBaseRoundType;

	public class HsMathUtil
	{
		public function HsMathUtil()
		{
		}
		
		/**
		 * Use to replace the default Number.toFixed function in order to
		 * avoid some known issue of it.
		 * 
		 * Don't use it in a huge number of computing, it will perform 
		 * slowly.
		 * 
		 * toFixed contains several issues listed as below:
		 * 1. for number like 1085.215 and precision is 1, it will return a
		 *    wrong result (1085.21), this issue is same as double type in Java.
		 * 2. for number like 0.000001 and precision is 2, it will return a
		 *    wrong result (0.01), this is a know issue of flash player 10.*;
		 * 
		 * 
		 * @param num target number
		 * @param precision precision to fix, default is -1
		 * @param roundType NumberBaseRoundType
		 * @param useFix enable fix, default is true
		 * @return
		 * 
		 */
		public static function toFixed(num:Number, 
									   precision:int = 0, 
									   roundType:String = 'nearest', 
									   useFix:Boolean = true):String
		{
			if (isNaN(num)) {
				return NaN.toString();
			} else if (!useFix) {
				return num.toFixed(precision);
			} else {
				var temp:Number = num + .0000000009; // this is a fix for incorrect rounding of 0.5
				var prec:Number = Math.pow(10, precision);
				if (roundType == NumberBaseRoundType.UP) {
					temp = Math.ceil(temp * prec) / prec;
				} else if (roundType == NumberBaseRoundType.DOWN) {
					temp = Math.floor(temp * prec) / prec;
				} else if (roundType == NumberBaseRoundType.NEAREST) {
					temp = Math.round(temp * prec) / prec;
				} else {
					return (temp - .0000000009).toString();
				}
				var result:String = temp.toFixed(precision);
				if (result.indexOf(".") == result.length - 1) {
					return result.substr(0, result.length - 1);
				}
				return result;
			}
		}
		
		public static function round(num:Number,
									 precision:int = 0,
									 roundType:String = 'nearest',
									 useFix:Boolean = true):Number
		{
			if (isNaN(num)) {
				return num;
			} else {
				var temp:Number = useFix ? num + .0000000009 : num;
				var prec:Number = Math.pow(10, precision);
				if (roundType == NumberBaseRoundType.UP) {
					return Math.ceil(temp * prec) / prec;
				} else if (roundType == NumberBaseRoundType.DOWN) {
					return Math.floor(temp * prec) / prec;
				} else if (roundType == NumberBaseRoundType.NEAREST) {
					return Math.round(temp * prec) / prec;
				} else {
					return num;
				}
			}
		}
	}
}
/**
 * Note, functions here should be tested carefully, please do NOT add any methods here
 * without fully tested.
 * 
 * @Author Jack Yin
 * 
 */
package com.common.util
{
	import mx.formatters.NumberBaseRoundType;
	
	public class FormatterUtil
	{
		public function FormatterUtil()
		{
		}
		
		/**
		 * convert scientific number to non-scientific number.
		 * 
		 * <p>
		 *   <table>
		 *     <tr>
		 *       <td>Origin</td>
		 *       <td>Result</td>
		 *     <tr>
		 *     <tr>
		 *       <td>1.78E5</td>
		 *       <td>178000</td>
		 *     <tr>
		 *     <tr>
		 *       <td>1.78E-3</td>
		 *       <td>0.00178</td>
		 *     <tr>
		 *   </table>
		 * </p>
		 * 
		 * @param value
		 * @return formatted result
		 * 
		 */
		public static function convertToNonScientificNumber(value:String):String
		{
			if (value != null && value.indexOf('E') >= 0) {
				value = value.split('e').join('E');
				var arr:Array = value.split('E');
				var tempNum:String;
				var pointIndex:int;
				var targetIndex:int;
				var i:int;
				if (arr.length == 2) {
					var num:String = arr[0];
					var pwd:String = arr[1];
					tempNum = num.split('.').join('');
					var isNagivate:Boolean = false;
					if (tempNum.indexOf('-') == 0) {
						isNagivate = true;
						tempNum = tempNum.substr(1);
					}
					if (num.indexOf('.') >= 0) {
						pointIndex = num.indexOf('.');
					} else {
						pointIndex = 2;
					}
					targetIndex = pointIndex + parseInt(pwd);
					if (parseFloat(pwd) > 0) {
						for (i = pointIndex + tempNum.length - 1; i < targetIndex; i++) {
							tempNum += "0";
						}
						tempNum = tempNum.substr(0, targetIndex) + '.' + tempNum.substr(targetIndex);
						tempNum = isNagivate ? '-' + tempNum : tempNum;
						return tempNum.indexOf('.') == tempNum.length - 1 ? tempNum.split('.').join('') : tempNum;
					} else if (parseInt(pwd) < 0) {
						for (i = 1; i < Math.abs(parseInt(pwd)); i++) {
							tempNum = "0" + tempNum;
						}
						tempNum = (isNagivate ? '-0.' : '0.') + tempNum;
						return tempNum;
					}
				}
			}
			return value;
		}
		
		/**
		 * format big decimal number.
		 * 
		 * @param str
		 * @param precisionString
		 * @param thousandChar
		 * @param decimalChar
		 * @param roundType
		 * @param symbol
		 * @return 
		 * 
		 */
		public static function formatBigDecimalNumberString(str:String, 
				precisionString:String = "",
				thousandChar:String = ",",
				decimalChar:String = ".",
				roundType:String = "nearest",
				symbol:String = ""):String {
			var numStr:String = convertToNonScientificNumber(str);
			var precison:int = precisionString.indexOf('.') > 0 ? precisionString.split('.')[1].length : 0;
			var precisonZero:int = precisionString.indexOf('.') > 0 ? String(precisionString.split('.')[1]).lastIndexOf('0') + 1 : 0;
			var i:int;
			var j:int;
			var nagSign:String = numStr.indexOf('-') == 0 ? '-' : '';
			if (nagSign == '-') {
				numStr = numStr.substr(1);
			}
			
			if (numStr == null || numStr.length == 0) {
				return "";
			}
			
			var arr:Array = numStr.split("");
			
			// firstly, do rounding
			if (roundType != NumberBaseRoundType.NONE) {
				var afterDecimal:Boolean = false;
				var afterDecimalIndex:int = 0;
				for (i = 0; i < arr.length; i++) {
					var s:String = arr[i] as String;
					if (s == '.') {
						afterDecimal = true;
						continue;
					}
					if (afterDecimal) {
						var sNum:int = parseInt(s);
						if (afterDecimalIndex + 1 > precison 
								&& (roundType == NumberBaseRoundType.UP 
									|| (sNum > 4 && roundType == NumberBaseRoundType.NEAREST))) {
							for (j = i; j >= 0; j--) {
								if (arr[j - 1] == '.') {
									continue;
								}
								arr[j - 1] = (parseInt(arr[j - 1]) + 1).toString();
								if (arr[j - 1] == 10 && j - 1 > 0) {
									arr[j - 1] = 0;
								} else {
									break;
								}
							}
							break;
						}
						afterDecimalIndex++;
					}
				}
			}
			
			// secondly, do thousand char formatter
			var decimalIndex:int = numStr.indexOf('.') == -1 ? arr.length : numStr.indexOf('.');
			var integerArr:Array = new Array();
			for (i = decimalIndex - 1; i >= 0; i--) {
				if (i == 0 && arr[i] == "10" && (decimalIndex) % 3 == 0) {
					arr[i] = "1,0";
				}
				integerArr.push(arr[i]);
				if ((decimalIndex - i) % 3 == 0 && decimalIndex != i && i != 0) {
					integerArr.push(',');
				}
			}
			
			var decimalArr:Array = new Array();
			for (i = decimalIndex + 1; i < decimalIndex + 1 + precison; i++) {
				if (arr.length <= i && i - decimalIndex <= precisonZero) {
					decimalArr.push("0");
				} else if (arr.length > i) {
					decimalArr.push(arr[i]);
				}
			}
			
			// thirdly, replace thousand char & decimal char & build the string
			var result:String = "";
			for (i = integerArr.length - 1; i >= 0; i--) {
				var t:String = integerArr[i];
				result += t;
			}
			result = result.replace(/,/g, thousandChar);
			
			if (numStr.indexOf('.') != -1 || precisonZero > 0) {
				result += decimalChar;
			}
			
			for (i = 0; i < decimalArr.length; i++) {
				result += decimalArr[i];
			}
			
			if (result.indexOf(decimalChar) == result.length - 1) {
				result = result.substr(0, result.length - 1);
			}
			
			return symbol + nagSign + result;
			
		}
		
		public static function test():void
		{
			var testArray:Array = [
				"0", "0.01", "999999.999999","9999999.999999", 
				"7.123456789E23",  "-7.123456789E23",  "7.123456789E-3", "-7.123456789E-3", 
				"-7.12345678923412312312312313E13", "0.00005", "8.989898989E44"
			];
			
			for each (var s:String in testArray) {
				trace (testNum(s, "#0", ".", ",", NumberBaseRoundType.NEAREST));
				trace (testNum(s, "#0.0000", ".", ",", NumberBaseRoundType.NEAREST));
				trace (testNum(s, "#0.0000", ".", ",", NumberBaseRoundType.DOWN));
				trace (testNum(s, "#0.0000", ".", ",", NumberBaseRoundType.UP));
				trace (testNum(s, "#0.0000###", ",", ".", NumberBaseRoundType.NEAREST));
				trace (testNum(s, "#0.#######", ".", ",", NumberBaseRoundType.NEAREST));
				trace (testNum(s, "#0.0000000", ".", ",", NumberBaseRoundType.NEAREST));
			}
		}
		
		public static function testNum(num:String, pre:String, thu:String, dec:String, rou:String):String
		{
			return num + "|" + convertToNonScientificNumber(num) + "|" + formatBigDecimalNumberString(num, pre, thu, dec, rou, "AUD ") + "|" + pre + "|" + thu + "|" + dec + "|" + rou;
		}
		
	}
}
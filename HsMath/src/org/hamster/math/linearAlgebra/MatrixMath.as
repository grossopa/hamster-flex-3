package org.hamster.math.linearAlgebra
{
	import flash.geom.Matrix;
	
	import mx.utils.ArrayUtil;

	/**
	 * Matrix class.
	 *  
	 * @author yinzeshuo
	 */
	public class MatrixMath
	{
		/**
		 * An two-dimensional array contains a list of Number. the length of
		 * this array should be [N * N], N is a nature number.
		 */
		private var _eles:Array;
		private var _rLength:int;
		private var _cLength:int;
		
		public function get rLength():int
		{
			return this._rLength;
		}
		
		public function get cLength():int
		{
			return this._cLength;
		}
		
		public function MatrixMath()
		{
		}
		
		public function initMatrix(eles:Array, rLength:int, cLength:int):MatrixMath
		{
			this._eles = [];
			this._rLength = rLength;
			this._cLength = cLength;
			var r:int;
			var c:int;
			
			if (eles.length > 0) {
				var firstEle:Object = eles[0];
				if (firstEle is Array) {
					for (r = 0; r < rLength; r++) {
						var cArray:Array = [];
						var ele:Array = eles[r];
						for (c = 0; c < cLength; c++) {
							cArray[c] = ele[c];
						}
						_eles[r] = cArray;
					}
				} else if (firstEle is Number) {
					for (r = 0; r < rLength; r++) {
						var cArr:Array = [];
						var rOffset:int = r * cLength;
						for (c = 0; c < cLength; c++) {
							cArr[c] = eles[rOffset + c];
						}
						this._eles[r] = cArr;
					}
				}
			}
			return this;
		}
		
		public function getValue(row:int, column:int):Number
		{
			return this._eles[row][column];
		}
		
		public function subMatrix(row:int, column:int, rLength:int, cLength:int):MatrixMath
		{
			var r:int;
			var c:int;
			var tmpArray:Array = [];
			
			for (r = 0; r < rLength; r++) {
				var offset:int = r * cLength;
				for (c = 0; c < cLength; c++) {
					tmpArray[offset + c] = this.getValue(row + r, column + c);
				}
			}
			
			var result:MatrixMath = new MatrixMath();
			return result.initMatrix(tmpArray, rLength, cLength);
		}
		
		public function getRow(row:int):MatrixMath
		{
			return this.subMatrix(row, 0, 1, this.cLength);
		}
		
		public function getColumn(column:int):MatrixMath
		{
			return this.subMatrix(0, column, this.rLength, 1);
		}
		
		public function toString():String
		{
			var result:String = '';
			for each (var rEle:Array in this._eles) {
				result += rEle.join(',') + '\n';
			}
			return result;
		}
	}
}
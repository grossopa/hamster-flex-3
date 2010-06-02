package org.hamster.math.linearAlgebra
{
	import flash.geom.Matrix;
	
	import mx.utils.ArrayUtil;
	
	import org.hamster.math.linearAlgebra.utils.MatrixMathUtil;

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
		/**
		 * length of row 
		 */
		private var _rLength:int;
		/**
		 * length of column 
		 */
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
		
		/**
		 * initialization from a Number array.
		 *  
		 * @param eles can be either array[array] or array[Number]
		 * @param rLength row length
		 * @param cLength column length
		 * @return this
		 */
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
		
		/**
		 * set value of location [r][c]. 
		 * 
		 * @param value
		 * @param row
		 * @param column
		 */
		public function setValue(value:Number, row:int, column:int):void
		{
			this._eles[row][column] = value;
		}
		
		/**
		 * get value of [r][c]
		 * 
		 * @param row
		 * @param column
		 * @return value
		 */
		public function getValue(row:int, column:int):Number
		{
			return this._eles[row][column];
		}
		
		/**
		 * sub the matrix.
		 *  
		 * @param row start row index
		 * @param column start column index
		 * @param rLength row length
		 * @param cLength column length
		 * @return new Matrix 
		 * 
		 */
		public function subMatrix(row:int, column:int, rLength:int, cLength:int):MatrixMath
		{
			var r:int;
			var c:int;
			var tmpArray:Array = [];
			
			for (r = 0; r < rLength; r++) {
				var offset:int = r * cLength;
				for (c = 0; c < cLength; c++) {
					tmpArray[offset + c] = _eles[row + r][column + c];
				}
			}
			
			var result:MatrixMath = new MatrixMath();
			return result.initMatrix(tmpArray, rLength, cLength);
		}
		
		/**
		 * get a row 
		 * 
		 * @param row
		 * @return new row Matrix
		 */
		public function getRow(row:int):MatrixMath
		{
			return this.subMatrix(row, 0, 1, this.cLength);
		}
		
		/**
		 * get a column
		 *  
		 * @param column
		 * @return new column Matrix
		 * 
		 */
		public function getColumn(column:int):MatrixMath
		{
			return this.subMatrix(0, column, this.rLength, 1);
		}
		
		/**
		 * multiply a number.
		 * 
		 * @param n the number to multiply
		 * @return this
		 */
		public function multiplyNumber(n:Number):MatrixMath
		{
			var rl:int = this.rLength;
			var cl:int = this.cLength;
			
			for (var r:int = 0; r < rl; r++) {
				for (var c:int = 0; c < cl; c++) {
					_eles[r][c] *= n;
				}
			}
			
			return this;
		}
		
		/////////////////////////////////
		// methods with another matrix //
		/////////////////////////////////
		/**
		 * If the row and column length of two matrix are same and all
		 * values of each position are same, then return true, else 
		 * return false.
		 *  
		 * @param m
		 * @return true if they are same
		 * 
		 */
		public function equals(m:MatrixMath):Boolean
		{
			if (!checkMatrixSize(m)) {
				return false;
			}
			var cl:int = m.cLength;
			var rl:int = m.rLength;
			
			for (var r:int = 0; r < rl; r++) {
				for (var c:int = 0; c < cl; c++) {
					if (_eles[r][c] != m.getValue(r, c)) {
						return false;
					}
				}
			}
			
			return true;
		}
		
		/**
		 * add another matrix
		 *  
		 * @param m
		 * @return this
		 */
		public function add(m:MatrixMath):MatrixMath
		{
			if (!checkMatrixSize(m)) {
				return null;
			}
			var cl:int = this.cLength;
			var rl:int = this.rLength;
			
			for (var r:int = 0; r < rl; r++) {
				for (var c:int = 0; c < cl; c++) {
					_eles[r][c] += m.getValue(r, c);
				}
			}
			return this;
		}
		
		/**
		 * check whether the rLength and cLength are same
		 *  
		 * @param m
		 * @return true if both of them are same
		 * 
		 */
		public function checkMatrixSize(m:MatrixMath):Boolean
		{
			return  m != null 
				&& this.cLength == m.cLength 
				&& this.rLength == m.rLength;
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
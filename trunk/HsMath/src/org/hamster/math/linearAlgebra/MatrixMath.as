package org.hamster.math.linearAlgebra
{
	import flash.geom.Matrix;
	
	import mx.utils.ArrayUtil;
	
	import org.hamster.math.linearAlgebra.utils.MatrixMathError;
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
		 * length of row, this value is possibly not equals
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
		 * initialization from a Number array. A new reference of object is created.
		 * So this method is a pass-by-value initialization method.
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
		 * set matrix from a formatted elements array, the style is array[array] which
		 * usually got from another Matrix instance. this is a pass-by-reference set
		 * method which means the reference of eles will be passed into this method.
		 * 
		 * @param eles
		 * @param rLength
		 * @param cLength
		 * @return this
		 * 
		 */
		public function setMatrix(eles:Array, rLength:int, cLength:int):MatrixMath
		{
			this._eles = eles;
			this._rLength = rLength;
			this._cLength = cLength;
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
			this.checkOutOfBound(row, column, MatrixMathError.OUT_OF_BOUND_MSG);
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
			this.checkOutOfBound(row, column, MatrixMathError.OUT_OF_BOUND_MSG);
			return this._eles[row][column];
		}
		
		/**
		 * get sub of the matrix
		 *  
		 * @param row start row index
		 * @param column start column index
		 * @param rLength row length
		 * @param cLength column length
		 * @return new Matrix 
		 * 
		 */
		public function getSubMatrix(row:int, column:int, rLength:int, cLength:int):MatrixMath
		{
			this.checkOutOfBound(row, column, MatrixMathError.OUT_OF_BOUND_MSG);
			var result:MatrixMath = new MatrixMath();
			result.setMatrix(this._eles, rLength, cLength);
			return result;
//			var r:int;
//			var c:int;
//			var tmpArray:Array = [];
//			
//			for (r = 0; r < rLength; r++) {
//				var offset:int = r * cLength;
//				for (c = 0; c < cLength; c++) {
//					tmpArray[offset + c] = _eles[row + r][column + c];
//				}
//			}
//			
//			var result:MatrixMath = new MatrixMath();
//			return result.initMatrix(tmpArray, rLength, cLength);
		}
		
		/**
		 * get a row 
		 * 
		 * @param row
		 * @return new row Matrix
		 */
		public function getRow(row:int):MatrixMath
		{
			this.checkOutOfBound(row, 0, MatrixMathError.OUT_OF_BOUND_MSG);
			return this.getSubMatrix(row, 0, 1, this.cLength);
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
			this.checkOutOfBound(0, column, MatrixMathError.OUT_OF_BOUND_MSG);
			return this.getSubMatrix(0, column, this.rLength, 1);
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
		
		/**
		 * Transpose a matrix.
		 *  
		 * @return this
		 */
		public function transpose():MatrixMath
		{
			var rl:int = this.rLength;
			var cl:int = this.cLength;
			
			var newEles:Array = [];
			for (var c:int = 0; c < cl; c++) {
				var ele:Array = [];
				for (var r:int = 0; r < rl; r++) {
					ele[r] = this._eles[r][c];
				}
				newEles[c] = ele;
			}
			
			this._eles = newEles;
			this._rLength = cl;
			this._cLength = rl;
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
			this.checkMatrixSize(m, MatrixMathError.SIZE_NOT_SAME_MSG);
			
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
		 * multiply with another matrix.
		 *  
		 * @param m
		 * @return this
		 * 
		 */
		public function multiply(m:MatrixMath):MatrixMath
		{
			var cm1:int = this.cLength;
			var rm2:int = m.rLength;
			var cm2:int = m.cLength;
			var rm1:int = this.rLength;
			
			if (cm1 != rm2) {
				return null;
			}
			
			var newEles:Array = [];
			for (var i:int = 0; i < rm1; i++) {
				var ele:Array = [];
				for (var j:int = 0; j < cm2; j++) {
					var cij:Number = 0;
					for (var p:int = 0; p < cm1; p++) {
						cij += _eles[i][p] * m.getValue(p, j);
					}
					ele[j] = cij;
				}
				newEles[i] = ele; 
			}
			
			return this.initMatrix(newEles, rm1, cm2);
		}
		
		/**
		 * check whether the rLength and cLength are same
		 *  
		 * @param m
		 * @return true if both of them are same
		 * 
		 */
		public function checkMatrixSize(m:MatrixMath, 
										errorMessage:String = ""):Boolean
		{
			var result:Boolean = m != null 
				&& this.cLength == m.cLength 
				&& this.rLength == m.rLength;
			if (!result && errorMessage != "") {
				throw new MatrixMathError(errorMessage, 
					MatrixMathError.SIZE_NOT_SAME);
			}
			return result;
		}
		
		public function checkOutOfBound(r:int, c:int, 
										  errorMessage:String = ""):Boolean
		{
			var result:Boolean =  r < _rLength
				&& c < _cLength && r >= 0 && c >= 0;
			if (!result && errorMessage != "") {
				throw new MatrixMathError(errorMessage, 
					MatrixMathError.OUT_OF_BOUND);
			}
			return result;
		}
		
		public function toString():String
		{
			var result:String = '';
			var rl:int = this.rLength;
			var cl:int = this.cLength;
			var c:int = 0;
			var r:int = 0;
			for (r = 0; r < rl - 1; r++) {
				for (c = 0; c < cl - 1; c++) {
					result += _eles[r][c] + ',';
				}
				result += _eles[r][cl - 1] + '\n';
			}
			for (c = 0; c < cl - 1; c++) {
				result += _eles[rl - 1][c] + ',';
			}
			result += _eles[rl - 1][cl - 1];
//			for each (var rEle:Array in this._eles) {
//				result += rEle.join(',') + '\n';
//			}
			return result;
		}
	}
}
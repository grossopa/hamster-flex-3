package or.hamster.math.matrix
{
	import flash.geom.Matrix;
	
	import mx.utils.ArrayUtil;
	
	import or.hamster.math.matrix.decomposition.LUDecomposition;
	import or.hamster.math.matrix.utils.MatrixMathError;
	import or.hamster.math.matrix.utils.MatrixMathUtil;

	/**
	 * Matrix class.
	 *  
	 * @author yinzeshuo
	 */
	public class MatrixMath
	{
		/**
		 * An two-dimensional array contains a list of Number.
		 * 
		 * The array should be [N][M].
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
		
		public function get eles():Array
		{
			return this._eles;
		}
		
		public function MatrixMath()
		{
		}
		
		/**
		 * Initialization from a Number array. A new reference of object is created.
		 * So this method is a pass-by-value initialization method.
		 *  
		 * @param eles can be either array[array[Number]] or array[Number]
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
		 * @param newMatrix return a new matrix if true
		 * @return this or a new matrix
		 */
		public function setValue(value:Number, row:int, column:int, 
			newMatrix:Boolean = false):MatrixMath
		{
			this.checkOutOfBound(row, column, MatrixMathError.OUT_OF_BOUND_MSG);
			var result:MatrixMath = this.getReturnMatrix(newMatrix);
			result.eles[row][column] = value;
			return result;
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
		 * get sub of the matrix, always return a new matrix.
		 *  
		 * @param row start row index
		 * @param column start column index
		 * @param rLength row length
		 * @param cLength column length
		 * @return new Matrix 
		 */
		public function getSubMatrix(row:int, column:int, rLength:int, cLength:int):MatrixMath
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
		 * A sub order matrix is a sub matrix of a matrix that removed its r row and c column.
		 * 
		 * <p>A(i|j) = </p>
		 * <table>
		 * <tr><td>a11</td><td>...</td><td>a1j-1</td><td>a1j+1</td><td>...</td><td>a1n</td></tr>
		 * <tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
		 * <tr><td>ai-11</td><td>...</td><td>ai-1j-1</td><td>ai-1j+1</td><td>...</td><td>ai-1n</td></tr>
		 * <tr><td>ai+11</td><td>...</td><td>ai+1j-1</td><td>ai+1j+1</td><td>...</td><td>ai+1n</td></tr>
		 * <tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
		 * <tr><td>an1</td><td>...</td><td>anj-1</td><td>anj+1</td><td>...</td><td>ann</td></tr>
		 * </table>
		 * 
		 * @param r removeRow
		 * @param c removeColumn
		 * @return A(r|c)
		 * 
		 */
		public function getSubOrderMatrix(r:int, c:int):MatrixMath
		{
			this.checkSquareMatrix(MatrixMathError.NOT_A_SQUARE_MATRIX_MSG);
			this.checkOutOfBound(r, c, MatrixMathError.OUT_OF_BOUND_MSG);
			var l:int = this._cLength;
			if (l <= 1) {
				throw new MatrixMathError("The dimensions of matrix must be larger than 1!");
			}
			
			var eles:Array = new Array();
			for (var i:int = 0; i < l; i++) {
				var tempE:Array = [];
				for (var j:int = 0; j < l; j++) {
					if (i == r || j == c) {
						continue;
					} else {
						tempE.push(this._eles[i][j]);
					}
				}
				if (i != r) {
					eles.push(tempE);
				}
			}
			
			var result:MatrixMath = new MatrixMath();
			result.setMatrix(eles, l - 1, l - 1);
			return result;
		}
		
		/**
		 * get cofactor of a determinant
		 * 
		 * Aij = |A(i|j)| * (-1)^(i + j)
		 * 
		 * @param r 
		 * @param c
		 * @return 
		 */
		public function cofactor(r:int, c:int):Number
		{
			var tempEles:Array = [];
			var rl:int = this._rLength;
			var cl:int = this._cLength;
			
			for (var i:int = 0; i < rl; i++) {
				var tempE:Array = [];
				for (var j:int = 0; j < cl; j++) {
					if (i == r || j == c) {
						continue;
					} else {
						tempE.push(this._eles[i][j]);
					}
				}
				if (i != r) {
					tempEles.push(tempE);
				}
			}
			
			var LUInfo:Array = LUDecomposition.initFromEles(tempEles, rl - 1, rl - 1);
			var result:Number = LUDecomposition.detFromLU(LUInfo[0], rl - 1, cl - 1, LUInfo[1]);
			
			if ((r + c) % 2 == 0) {
				return result;
			} else {
				return - result;
			}
		}
		
		/**
		 * get adjoint of the matrix, always return a new matrix
		 * 
		 * <p>A* = </p>
		 * <table>
		 * <tr><td>A11</td><td>A12</td><td>...</td><td>A1n</td></tr>
		 * <tr><td>A21</td><td>A22</td><td>...</td><td>A2n</td></tr>
		 * <tr><td>...</td><td>...</td><td>...</td><td>...</td></tr>
		 * <tr><td>An1</td><td>An2</td><td>...</td><td>Ann</td></tr>
		 * 
		 * @return adjoint matrix
		 * 
		 */
		public function adjoint():MatrixMath
		{
			var rl:int = this._rLength;
			var cl:int = this._cLength;
			
			var tempEles:Array = [];
			for (var i:int = 0; i < rl; i++) {
				var tempE:Array = [];
				for (var j:int = 0; j < cl; j++) {
					tempE[j] = this.getSubOrderMatrix(i, j);
				}
				tempEles[i] = tempE;
			}
			var result:MatrixMath = new MatrixMath();
			result.setMatrix(tempEles, rl, cl);
			return result;
		}
		
		/**
		 * get a row, always return a new matrix
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
		 * get a column, always return a new matrix
		 *  
		 * @param column
		 * @return new column Matrix
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
		 * @param newMatrix return a new matrix if true.
		 * @return this or a new matrix
		 */
		public function multiplyNumber(n:Number, 
			newMatrix:Boolean = false):MatrixMath
		{
			var result:MatrixMath = this.getReturnMatrix(newMatrix);
			var e:Array = result.eles;
			var rl:int = result.rLength;
			var cl:int = result.cLength;
			
			for (var r:int = 0; r < rl; r++) {
				for (var c:int = 0; c < cl; c++) {
					e[r][c] *= n;
				}
			}
			return result;
		}
		
		/**
		 * Transpose a matrix
		 *
		 * @param newMatrix return a new matrix if true.  
		 * @return this or a new matrix
		 */
		public function transpose(newMatrix:Boolean = false):MatrixMath
		{
			var result:MatrixMath = this.getReturnMatrix(newMatrix);
			var e:Array = result.eles;
			var rl:int = result.rLength;
			var cl:int = result.cLength;
			
			var newEles:Array = [];
			for (var c:int = 0; c < cl; c++) {
				var ele:Array = [];
				for (var r:int = 0; r < rl; r++) {
					ele[r] = e[r][c];
				}
				newEles[c] = ele;
			}
			
			result.setMatrix(newEles, rl, cl);
			return result;
		}
		
		/**
		 * use LU decomposition to get two array of the matrix,
		 * the matrix must be an n*n matrix otherwise an error is thrown.
		 *  
		 * @return 
		 */
		public function lu():void
		{
			this.checkSquareMatrix(MatrixMathError.NOT_A_SQUARE_MATRIX_MSG);
						
		}
		
		/**
		 * det
		 * 
		 * @return result
		 */
		public function det():Number
		{
			return LUDecomposition.detOfMatrix(this);
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
		 */
		public function equals(m:MatrixMath):Boolean
		{
			if (!checkMatrixDimensions(m)) {
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
		 * @param newMatrix return a new matrix if true.
		 * @return this or a new matrix
		 */
		public function add(m:MatrixMath, newMatrix:Boolean = false):MatrixMath
		{
			this.checkMatrixDimensions(m, MatrixMathError.SIZE_NOT_SAME_MSG);
			var result:MatrixMath = this.getReturnMatrix(newMatrix);
			var e:Array = result.eles;
			var cl:int = result.cLength;
			var rl:int = result.rLength;
			
			var e2:Array = m.eles;
			
			for (var r:int = 0; r < rl; r++) {
				for (var c:int = 0; c < cl; c++) {
					e[r][c] += e2[r][c];
				}
			}
			return result;
		}
		
		/**
		 * multiply with another matrix.
		 *  
		 * @param m
		 * @param newMatrix return a new matrix if true.
		 * @return this or a new matrix
		 */
		public function multiply(m:MatrixMath, 
								 newMatrix:Boolean = false):MatrixMath
		{
			var result:MatrixMath = this.getReturnMatrix(newMatrix);
			
			var e:Array = result.eles;
			var cm1:int = result.cLength;
			var rm2:int = m.rLength;
			var cm2:int = m.cLength;
			var rm1:int = result.rLength;
			
			var e2:Array = m.eles;
			
			if (cm1 != rm2) {
				throw new MatrixMathError('The column length of left matrix should be same as row length of right matrix!');
			}
			
			var newEles:Array = [];
			for (var i:int = 0; i < rm1; i++) {
				var ele:Array = [];
				for (var j:int = 0; j < cm2; j++) {
					var cij:Number = 0;
					for (var p:int = 0; p < cm1; p++) {
						cij += e[i][p] * e2[p][j];
					}
					ele[j] = cij;
				}
				newEles[i] = ele; 
			}
			
			return result.setMatrix(newEles, rm1, cm2);
		}
		
		//////////////////////////
		// basic transformation //
		//////////////////////////
		/**
		 * Basic transformation of a matrix. Exchange two rows of a matrix 
		 * r1 <-> r2
		 * 
		 * @param row1
		 * @param row2
		 * @param newMatrix return a new matrix if true.
		 * @return this or a new matrix
		 */
		public function exchangeRow(row1:int, row2:int, 
									newMatrix:Boolean = false):MatrixMath
		{
			if (row1 >= this._rLength || row2 > this._rLength 
				|| row1 < 0 || row2 < 0) {
				throw new MatrixMathError(MatrixMathError.OUT_OF_BOUND_MSG, 
					MatrixMathError.OUT_OF_BOUND);
			}
			
			var result:MatrixMath = this.getReturnMatrix(newMatrix);
			var cl:int = result.cLength;
			var e:Array = result.eles;
			for (var c:int = 0; c < cl; c++) {
				var t:Number = e[row1][c];
				e[row1][c] = e[row2][c];
				e[row2][c] = t;
			}
			return result;
		}
		
		/**
		 * Basic transformation of a matrix. The number should not be 0.
		 * r1 -> num * r1
		 * 
		 * @param num
		 * @param row
		 * @param newMatrix return a new matrix if true.
		 * @return this or a new matrix
		 */
		public function multiplyRow(num:Number, row:int,
			newMatrix:Boolean = false):MatrixMath
		{
			if (num == 0) {
				throw new MatrixMathError("The number should not be 0!");
			}
			this.checkOutOfBound(row, 0, MatrixMathError.OUT_OF_BOUND_MSG);
			
			var result:MatrixMath = this.getReturnMatrix(newMatrix);
			var e:Array = result.eles;
			var cl:int = this._cLength;
			var tempE:Array = e[row];
			for (var c:int = 0; c < cl; c++) {
				tempE[c] *= num;
			}
			return result;
		}
		
		/**
		 * Basic transformation of a matrix.
		 * r2 -> num * r1 + r2
		 * 
		 * @param num
		 * @param row1
		 * @param row2
		 * @param newMatrix return a new matrix if true.
		 * @return this or a new matrix
		 */
		public function multiplyAndAddTo(num:Number, row1:int, row2:int, 
			newMatrix:Boolean = false):MatrixMath
		{
			if (row1 < 0 || row1 >= this._rLength 
				|| row2 < 0 || row2 >= this._rLength) {
				throw new MatrixMathError(MatrixMathError.OUT_OF_BOUND);
			}
			var result:MatrixMath = this.getReturnMatrix(newMatrix);
			var eleRow1:Array = result.eles[row1];
			var eleRow2:Array = result.eles[row2];
			var cl:int = this._cLength;
			for (var c:int = 0; c < cl; c++) {
				eleRow2[c] = eleRow1[c] * num + eleRow2[c];
			}
			return result;
		}
		
//		public function exchangeColumn(column1:int, column2:int):MatrixMath
//		{
//			if (column1 >= this._cLength || column2 > this._cLength 
//				|| column1 < 0 || column2 < 0) {
//				throw new MatrixMathError(MatrixMathError.OUT_OF_BOUND_MSG, 
//					MatrixMathError.OUT_OF_BOUND);
//			}
//			
//			var rl:int = _rLength;
//			for (var r:int = 0; r < rl; r++) {
//				var t:Number = _eles[column1][r];
//				_eles[column1][r] = _eles[column2][r];
//				_eles[column2][r] = t;
//			}
//			return this;
//		}
	
		///////////////////
		// check methods //
		///////////////////
		/**
		 * check whether the rLength and cLength are same
		 *  
		 * @param m
		 * @return true if both of them are same
		 */
		public function checkMatrixDimensions(m:MatrixMath, 
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
		
		/**
		 * Whether row or column are out of bound
		 * 
		 * @param r
		 * @param c
		 * @param errorMessage If error message is empty, then no Error
		 *                     is thrown.
		 * @return is out of Bound
		 */
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
		
		/**
		 * Check whether the matrix is a square(n * n) matrix.
		 *  
		 * @param errorMessage If error message is empty, then no Error
		 *                     is thrown.
		 * @return whether the matrix is square.
		 */
		public function checkSquareMatrix(errorMessage:String = ""):Boolean
		{
			var result:Boolean = _rLength == _cLength;
			if (!result && errorMessage != "") {
				throw new MatrixMathError(errorMessage,
					MatrixMathError.NOT_A_SQUARE_MATRIX);
			}
			return result;
		}
		
		//////////////////
		// util methods //
		//////////////////
		/**
		 * @private
		 * @param isCreateNewMatrix
		 * @return 
		 */
		private function getReturnMatrix(
			isCreateNewMatrix:Boolean):MatrixMath
		{
			if (isCreateNewMatrix) {
				return this.clone();
			} else {
				return this;
			}
		}
		
		/**
		 * return a copy of eles array.
		 * 
		 * @return copied array
		 */
		public function getElesCopy():Array
		{
			var result:Array = [];
			var rl:int = _rLength;
			var cl:int = _cLength;
			
			for (var r:int = 0; r < rl; r++) {
				var cArray:Array = [];
				for (var c:int = 0; c < cl; c++) {
					cArray[c] = _eles[r][c];
				}
				result[r] = cArray;
			}
			return result;
		}
		
		/**
		 * @private 
		 * @return new matrix 
		 */
		public function clone():MatrixMath
		{
			var newMatrix:MatrixMath = new MatrixMath();
			newMatrix.initMatrix(this._eles, this._rLength, this._cLength);
			return newMatrix;			
		}
		
		/**
		 * @private
		 * @return 
		 */
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
			return result;
		}
	}
}
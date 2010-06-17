package or.hamster.math.matrix.decomposition
{
	import or.hamster.math.matrix.MatrixMath;
	import or.hamster.math.matrix.utils.MatrixMathError;

	/**
	 * Translated from Jama.
	 *  
	 * @author yinzeshuo
	 * 
	 */
	public class LUDecomposition
	{
		private var _LU:Array;
		private var _rLength:int;
		private var _cLength:int;
		private var _pivsign:int;
		
		public function LUDecomposition(matrix:MatrixMath)
		{
			var result:Array = initFromMatrix(matrix);
			_LU = result[0];
			_pivsign = result[1];
			_rLength = matrix.rLength;
			_cLength = matrix.cLength;
		}
		
		/**
		 *  
		 * @return 
		 * 
		 */
		public function det():Number
		{
			return detFromLU(this._LU, this._rLength, this._cLength, this._pivsign);
		}
		
		public static function detOfMatrix(matrix:MatrixMath):Number
		{
			var resultInfo:Array = initFromMatrix(matrix);
			return detFromLU(resultInfo[0], 
				matrix.rLength, matrix.cLength, resultInfo[1]);
		}
		
		public static function initFromMatrix(matrix:MatrixMath):Array
		{
			var eles:Array = matrix.getElesCopy();
			var rl:int = matrix.rLength;
			var cl:int = matrix.cLength;
			return initFromEles(eles, rl, cl);
		}
		
		public static function initFromEles(eles:Array, rl:int, cl:int):Array
		{
			// Use a "left-looking", dot-product, Crout/Doolittle algorithm.
			var i:int;
			var j:int;
			var k:int;
			var piv:Array = [];
			var pivsign:int = 1;
			
			for (i = 0; i < rl; i++) {
				piv[i] = i;
			}
			
			var LUrowi:Array = [];
			var LUcolj:Array = [];
			
			// Outer loop.
			for (j = 0; j < cl; j++) {
				// Make a copy of the j-th column to localize references.
				for (i = 0; i < rl; i++) {
					LUcolj[i] = eles[i][j];
				}
				
				// Apply previous transformations.
				for (i = 0; i < rl; i++) {
					LUrowi = eles[i];
					
					// Most of the time is spent in the following dot product.
					var kmax:int = Math.min(i, j);
					var s:Number = 0;
					for (k = 0; k < kmax; k++) {
						s += LUrowi[k] * LUcolj[k];
					}
					
					LUcolj[i] -= s;
					LUrowi[j] = LUcolj[i];
				}
				
				// Find pivot and exchange if necessary.
				var p:int = j;
				for (i = j + 1; i < rl; i++) {
					if (Math.abs(LUcolj[i]) > Math.abs(LUcolj[p])) {
						p = i;
					}
				}
				if (p != j) {
					for (k = 0; k < cl; k++) {
						var t:Number = eles[p][k];
						eles[p][k] = eles[j][k];
						eles[j][k] = t;
					}
					k = piv[p]; 
					piv[p] = piv[j]; 
					piv[j] = k;
					pivsign = -pivsign;
				}
				
				// Compute multipliers.
				if (j < rl && eles[j][j] != 0) {
					for (i = j + 1; i < rl; i++) {
						eles[i][j] /= eles[j][j];
					}
				}
			}
			return [eles, pivsign];			
		}
		
		public static function detFromLU(LU:Array, rl:int, cl:int, pivsign:int):Number
		{
			if (rl != cl) {
				throw new MatrixMathError(MatrixMathError.NOT_A_SQUARE_MATRIX_MSG, 
					MatrixMathError.NOT_A_SQUARE_MATRIX);
			}
			var d:Number = pivsign;
			for (var j:int = 0; j < rl; j++) {
				d *= LU[j][j];
			}
			return d;		
		}
	}
}
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
		private var _eles:Array;
		private var _rLength:int;
		private var _cLength:int;
		private var _piv:Array;
		private var _pivsign:int;
		
		public function LUDecomposition(matrix:MatrixMath)
		{
			// Use a "left-looking", dot-product, Crout/Doolittle algorithm.
			var i:int;
			var j:int;
			var k:int;
			
			_eles = matrix.getElesCopy();
			_rLength = matrix.rLength;
			_cLength = matrix.cLength;
			
			_piv = [];
			for (i = 0; i < _rLength; i++) {
				_piv[i] = i;
			}
			
			_pivsign = 1;
			
			var LUrowi:Array = [];
			var LUcolj:Array = [];
			
			// Outer loop.
			for (j = 0; j < _cLength; j++) {
				// Make a copy of the j-th column to localize references.
				for (i = 0; i < _rLength; i++) {
					LUcolj[i] = _eles[i][j];
				}
				
				// Apply previous transformations.
				for (i = 0; i < _rLength; i++) {
					LUrowi = _eles[i];
					
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
				for (i = j + 1; i < _rLength; i++) {
					if (Math.abs(LUcolj[i]) > Math.abs(LUcolj[p])) {
						p = i;
					}
				}
				if (p != j) {
					for (k = 0; k < _cLength; k++) {
						var t:Number = _eles[p][k];
						_eles[p][k] = _eles[j][k];
						_eles[j][k] = t;
					}
					k = _piv[p]; 
					_piv[p] = _piv[j]; 
					_piv[j] = k;
					_pivsign = -_pivsign;
				}
				
				// Compute multipliers.
				
				if (j < _rLength && _eles[j][j] != 0) {
					for (i = j + 1; i < _rLength; i++) {
						_eles[i][j] /= _eles[j][j];
					}
				}
			}
		}
		
		/**
		 *  
		 * @return 
		 * 
		 */
		public function det():Number
		{
			if (_rLength != _cLength) {
				throw new MatrixMathError(MatrixMathError.NOT_A_SQUARE_MATRIX_MSG, 
					MatrixMathError.NOT_A_SQUARE_MATRIX);
			}
			var d:Number = _pivsign;
			for (var j:int = 0; j < _cLength; j++) {
				d *= _eles[j][j];
			}
			return d;
		}
	}
}
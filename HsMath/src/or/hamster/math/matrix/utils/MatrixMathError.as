package or.hamster.math.matrix.utils
{
	public class MatrixMathError extends Error
	{
		public static const SIZE_NOT_SAME:int = 896401;
		public static const OUT_OF_BOUND:int = 896402;
		public static const NOT_A_SQUARE_MATRIX:int = 896403;
		
		public static const SIZE_NOT_SAME_MSG:String = "The sizes of two martix are not same.";
		public static const OUT_OF_BOUND_MSG:String = "The index is out of bounds.";
		public static const NOT_A_SQUARE_MATRIX_MSG:String = "The matrix is not a square matrix.";

		/**
		 * default constructor
		 *  
		 * @param message
		 * @param id
		 */
		public function MatrixMathError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}
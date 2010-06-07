package org.hamster.math.linearAlgebra.test
{
	import flexunit.framework.TestCase;
	
	import org.hamster.math.linearAlgebra.MatrixMath;
	
	public class MatrixTest extends TestCase
	{
		public function MatrixTest(methodName:String=null)
		{
			super(methodName);
		}
		
		override public function setUp():void
		{
			super.setUp();
		}
		
		override public function tearDown():void
		{
			super.tearDown();
		}
		
		public function testMatrix():void
		{
			var matrix:MatrixMath = new MatrixMath();
			matrix.initMatrix([[1,2,3,4,5],[2,3,4,5,6],[3,4,5,6,7],[4,5,6,7,8]], 4, 5);
			trace(matrix.getValue(1, 2));
			trace("-----");
			trace(matrix.toString());
			trace("-----");
			trace(matrix.getSubMatrix(2,1,2,2).toString());
			trace("-----");
			trace(matrix.getRow(3));
			trace("-----");
			trace(matrix.getColumn(2));
			trace("-----");
			trace(matrix.transpose().toString());
		}
		
		public function testMultiply():void
		{
			var m1:MatrixMath = new MatrixMath();
			m1.initMatrix([[1],[2],[3],[4]], 4, 1);
			var m2:MatrixMath = new MatrixMath();
			m2.initMatrix([1, 2, 3, 4], 1, 4);
			trace(m1.multiply(m2).toString());
			
		}
		
	}
}
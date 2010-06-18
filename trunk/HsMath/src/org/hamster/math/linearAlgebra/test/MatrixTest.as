package org.hamster.math.linearAlgebra.test
{
	import flash.geom.Matrix;
	
	import flexunit.framework.Assert;
	import flexunit.framework.TestCase;
	
	import mx.managers.ISystemManager;
	
	import or.hamster.math.matrix.MatrixMath;
	
	[Mixin]
	public class MatrixTest extends TestCase
	{
		public static var baseMatrix1:MatrixMath = new MatrixMath();
		public static var idenMatrix1:MatrixMath = new MatrixMath();
		
		public static function init(systemManager:ISystemManager):void {
			//baseMatrix1.initMatrix([[5,2,1,3,4],[7,9,1,2,5],[1,6,5,6,7],[8,8,9,9,8],[5,6,7,8,9]], 5, 5);
			//idenMatrix1.initMatrix([[1,0,0,0,0],[0,1,0,0,0],[0,0,1,0,0],[0,0,0,1,0],[0,0,0,0,1]], 5, 5);
			baseMatrix1.initMatrix([[-3,2,-5],[-1,0,-2],[3,-4,1]], 3, 3);
			idenMatrix1.initMatrix([[1,0,0],[0,1,0],[0,0,1]], 3, 3);
		}
		
		
		public function MatrixTest(methodName:String=null)
		{
			super(methodName);
		}
		
		override public function setUp():void
		{
			trace ("-------- " + this.methodName + " -------");
			super.setUp();
		}
		
		override public function tearDown():void
		{
			super.tearDown();
		}
		
		public function testCofactor():void
		{
			trace ("-----");
			trace (baseMatrix1.toString());
			trace ("-----");
			var adjointMatrix:MatrixMath = baseMatrix1.adjoint();
			
			trace (adjointMatrix.toString());
			
			var aMultiAStar:MatrixMath = baseMatrix1.multiply(adjointMatrix, true);
			var aStarMultiA:MatrixMath = adjointMatrix.multiply(baseMatrix1, true);
			trace ("-----");
			trace (aMultiAStar.toString());
			trace ("-----");
			trace (aStarMultiA.toString());
			Assert.assertTrue(aMultiAStar.equals(aStarMultiA));
			Assert.assertTrue(aMultiAStar.equals(idenMatrix1.multiplyNumber(baseMatrix1.det(), true)));
		}
		
	}
}
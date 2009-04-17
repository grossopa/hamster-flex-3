package org.hamster.test.undo.model
{
	import flash.geom.Point;
	
	import org.hamster.test.undo.TestDragableUnit;
	
	public class DataSource
	{
		public var id:String;
		public var name:String;
		public var point:Point;
		public var address:String;	
		public var currentTarget:TestDragableUnit;

	}
}
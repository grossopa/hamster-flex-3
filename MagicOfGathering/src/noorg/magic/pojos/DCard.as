package noorg.magic.pojos
{
	import flash.data.SQLStatement;
	
	import noorg.magic.pojos.base.AbstractPojo;

	public class DCard extends AbstractPojo
	{
		public function DCard()
		{
			super();
		}
		
		public var pid:int;
		public var name:String;
		public var imgUrl:String;
		public var description:String;
		
		override public function getTableName():String
		{
			return "card";
		}
		
		override public function get sqlText():String
		{
			return "CREATE TABLE IF NOT EXISTS card(" +
					"pid INTEGER, " +
 					"name STRING, " +
 					"imgUrl STRING, " +
 					"description STRING)";
		}
	}
}
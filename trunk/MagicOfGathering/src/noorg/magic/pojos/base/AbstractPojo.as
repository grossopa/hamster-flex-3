package noorg.magic.pojos.base
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	
	public class AbstractPojo implements IPojo
	{
		public function AbstractPojo()
		{
		}
		
		public function getTableName():String
		{
			return "";
		}
		
		public function get sqlText():String
		{
			return null;
		}		
	}
}
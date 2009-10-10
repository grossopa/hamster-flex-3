package noorg.magic.pojos.base
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	
	public interface IPojo
	{
		function getTableName():String;
		function get sqlText():String;
	}
}
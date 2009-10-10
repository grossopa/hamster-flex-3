package noorg.magic.commands.impl.init
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	
	import noorg.magic.pojos.base.IPojo;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.commands.ICommand;

	public class CreateSchemaCmd extends AbstractCommand
	{
		public var conn:SQLConnection;		
		public var sqlStatement:SQLStatement;
		
		public var pojo:IPojo;
		
		public function CreateSchemaCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			if (this.cmdWrapper != null && this.conn == null) {
				for each (var cmd:ICommand in this.cmdWrapper.cmdArray) {
					if (cmd is InitializeDatabaseCmd) {
						this.conn = InitializeDatabaseCmd(cmd).conn;
					}		
				}
			}
			sqlStatement = new SQLStatement();
			sqlStatement.sqlConnection = conn;
			sqlStatement.text = this.pojo.sqlText;
			sqlStatement.execute(-1, this.flashNetResponder);
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
		}
		
		override public function fault(info:Object):void
		{
			super.fault(info);
		}
		
	}
}
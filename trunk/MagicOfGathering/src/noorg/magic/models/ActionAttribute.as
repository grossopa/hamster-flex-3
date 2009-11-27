package noorg.magic.models
{
	public class ActionAttribute
	{
		public static const TYPE_INT:String 	= "typeInt";
		public static const TYPE_LIST:String 	= "typeList";
		public static const TYPE_STRING:String 	= "typeString";
		
		public var name:String;
		public var type:String;
		public var listData:Array;
		
		public function ActionAttribute(name:String, type:String, listData:Array = null)
		{
			this.name = name;
			this.type = type;
			this.listData = listData;
		}

	}
}
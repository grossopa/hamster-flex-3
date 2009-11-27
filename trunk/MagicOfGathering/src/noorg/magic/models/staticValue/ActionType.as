package noorg.magic.models.staticValue
{
	import noorg.magic.actions.magicPool.MagicPoolChangeAction;
	
	public class ActionType
	{
		public static const MAGIC_POOL_CHANGE:String = "MagicPoolChange";
		
		public static function get actionTypes():Array
		{
			return  [{label:"MAGIC_POOL_CHANGE", data:MagicPoolChangeAction}];
		}
	}
}
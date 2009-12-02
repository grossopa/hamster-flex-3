package noorg.magic.models.staticValue
{
	import noorg.magic.actions.magicPool.MagicPoolChangeAction;
	
	public class ActionType
	{
		public static const MAGIC_POOL_CHANGE:String = "MagicPoolChange";
		public static const CAST_CARD:String = "CastCard";
		
		public static function get actionTypes():Array
		{
			return  [
						{label:"Magic Pool Change", data:MagicPoolChangeAction}
					];
		}
	}
}
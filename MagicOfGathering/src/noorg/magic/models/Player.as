package noorg.magic.models
{
	import noorg.magic.events.PlayerEvent;
	import noorg.magic.models.base.AbstractModelSupport;
	
	public class Player extends AbstractModelSupport
	{
		public var name:String;
		
		private var _hp:int;
		
		public function set hp(value:int):void
		{
			this._hp = value;
			this.dispatchEvent(new PlayerEvent(PlayerEvent.HP_CHANGED));
		}
		
		public function get hp():int
		{
			return this._hp;
		}
		
		public var cardColl:CardCollection;
		public var playerCardColl:PlayerCardColl;
		
		
		
	}
}
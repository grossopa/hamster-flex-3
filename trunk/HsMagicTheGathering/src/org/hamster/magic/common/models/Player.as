package org.hamster.magic.common.models
{

	public class Player extends AbstractModelSupport
	{
		private var _hp:int = 20;
		
		public function set hp(value:int):void
		{
			this._hp = value;
			// this.dispatchEvent(new PlayerEvent(PlayerEvent.HP_CHANGE));
		}
		
		public function get hp():int
		{
			return this._hp;
		}
		
		public var cards:CardCollection;
		public var playerCards:PlayerCards;
		
		
	}
}
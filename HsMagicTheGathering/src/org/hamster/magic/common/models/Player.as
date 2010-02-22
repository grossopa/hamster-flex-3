package org.hamster.magic.common.models
{
	import org.hamster.magic.common.events.PlayerEvent;
	import org.hamster.magic.common.models.base.AbstractModelSupport;
	
	[Event(name="lifeChange", type="org.hamster.magic.common.events.PlayerEvent")]

	public class Player extends AbstractModelSupport
	{
		private var _life:int = 20;
		public const magic:Magic = new Magic();
		
		public function set life(value:int):void
		{
			this._life = value;
			this.dispatchEvent(new PlayerEvent(PlayerEvent.LIFE_CHANGE));
		}
		
		public function get life():int
		{
			return this._life;
		}
		
		public var cardCollection:CardCollection;
		public var playerCards:PlayerCards;
		
		
	}
}
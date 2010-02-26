package org.hamster.magic.common.models.type
{
	import org.hamster.magic.common.events.PlayerEvent;
	import org.hamster.magic.common.models.base.ILifeTarget;
	import org.hamster.magic.common.models.type.base.CardTypeBase;
	import org.hamster.magic.common.models.type.base.ICardType;
	import org.hamster.magic.common.models.type.utils.CardType;
	
	public class TypeCreature extends CardTypeBase implements ILifeTarget
	{
		public var attack:int;
		public var defense:int;
		public var isFlying:Boolean;
		public var isReach:Boolean;
		public var isFirstStrike:Boolean;
		
		
		public var isDoubleStrike:Boolean;
		public var isHaste:Boolean;
		public var isTrample:Boolean;
		public var isVigilance:Boolean;
		public var isLangwale:Boolean;
		
		
		private var _life:int;
		
		public function set life(value:int):void
		{
			this._life = value;
			this.dispatchEvent(new PlayerEvent(PlayerEvent.LIFE_CHANGE));
		}
		
		public function get life():int
		{
			return this._life;
		}
		
		override public function get defaultActions():Array
		{
			return [];
		}
		
		override public function get attributes():Array
		{
			return ["attack", "defense", "isFlying", "isReach", "isFirstStrike"];
		}		
		public function TypeCreature()
		{
			super();
			
			type = CardType.CREATURE;
		}
		
		public function revertLife():void
		{
			this.life = this.defense;
		}
		
		override public function decodeXML(xml:XML):void
		{
			this.attack = xml.@attack;
			this.defense = xml.@defense;
			this.isFlying = xml.attribute("is-flying") == "true";
			this.isReach = xml.attribute("is-reach") == "true";
			this.isFirstStrike = xml.attribute("is-first-strike") == "true";
		}
		
		override public function encodeXML():XML
		{
			var xml:XML = new XML(<type name={type} attack={attack} defense={defense} 
					is-flying={isFlying} is-reach={isReach} is-first-strike={isFirstStrike}
					></type>);
			return xml;
		}
		
		override public function clone():ICardType
		{
			var result:TypeCreature = new TypeCreature();
			result.attack = this.attack;
			result.defense = this.defense;
			result.isFlying = this.isFlying;
			result.isReach = this.isReach;
			result.isFirstStrike = this.isFirstStrike;
			result.card = this.card;
			return result;
		}
		
	}
}
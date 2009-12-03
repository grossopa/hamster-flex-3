package noorg.magic.models.types
{
	import noorg.magic.models.staticValue.CardType;
	import noorg.magic.models.types.base.CardTypeBase;
	import noorg.magic.models.types.base.ICardType;

	public class TypeCreature extends CardTypeBase
	{
		public var attack:int;
		public var defense:int;
		public var isFlying:Boolean;
		public var isReach:Boolean;
		public var isFirstStrike:Boolean;
		
		public function TypeCreature()
		{
			super();
			
			type = CardType.CREATURE;
		}
		
		override public function get defaultActions():Array
		{
			return [];
		}
		
		override public function get attributes():Array
		{
			return ["attack", "defense", "isFlying", "isReach", "isFirstStrike"];
		}
		
		override public function decodeXML(xml:XML):void
		{
			this.attack = xml.@attack;
			this.defense = xml.@defense;
			this.isFlying = xml.attribute("is-flying") as String == "true";
			this.isReach = xml.attribute("isReach") as String == "true";
			this.isFirstStrike = xml.attribute("is-first-strike") as String == "true";
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
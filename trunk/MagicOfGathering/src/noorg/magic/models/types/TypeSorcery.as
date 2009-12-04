package noorg.magic.models.types
{
	import noorg.magic.models.staticValue.CardType;
	import noorg.magic.models.types.base.CardTypeBase;
	import noorg.magic.models.types.base.ICardType;

	public class TypeSorcery extends CardTypeBase
	{
		public function TypeSorcery()
		{
			super();
			
			this.type = CardType.INSTANT;
		}
		
		override public function get defaultActions():Array
		{
			return [];
		}
		
		override public function get attributes():Array
		{
			return [];
		}
		
		override public function decodeXML(xml:XML):void
		{
		}
		
		override public function encodeXML():XML
		{
			var xml:XML = new XML(<type name={type}></type>);
			return xml;
		}
		
		override public function clone():ICardType
		{
			var result:TypeSorcery = new TypeSorcery();
			result.card = this.card;
			return result;
		}
		
	}
}
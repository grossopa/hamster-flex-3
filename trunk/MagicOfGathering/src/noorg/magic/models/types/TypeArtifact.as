package noorg.magic.models.types
{
	import noorg.magic.models.staticValue.CardType;
	import noorg.magic.models.types.base.CardTypeBase;
	import noorg.magic.models.types.base.ICardType;

	public class TypeArtifact extends CardTypeBase
	{
		public function TypeArtifact()
		{
			super();
			
			this.type = CardType.ARTIFACT;
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
			var result:TypeArtifact = new TypeArtifact();
			result.card = this.card;
			return result;
		}
	}
}
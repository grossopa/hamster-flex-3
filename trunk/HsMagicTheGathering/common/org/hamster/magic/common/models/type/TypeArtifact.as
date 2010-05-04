package org.hamster.magic.common.models.type
{
	import org.hamster.magic.common.models.type.base.CardTypeBase;
	import org.hamster.magic.common.models.type.base.ICardType;
	import org.hamster.magic.common.models.type.utils.CardType;
	

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
package org.hamster.magic.common.models.type.base
{
	import org.hamster.magic.common.models.Card;

	public class CardTypeBase implements ICardType
	{
		private var _type:int;
		private var _card:Card;
		
		public function CardTypeBase()
		{
		}

		public function set card(value:Card):void
		{
			this._card = value;
		}
		
		public function get card():Card
		{
			return this._card;
		}
		
		public function set type(value:int):void
		{
			this._type = value;
		}
		
		public function get type():int
		{
			return this._type;
		}
		
		public function get defaultActions():Array
		{
			return [];	
		}
		
		public function get attributes():Array
		{
			return [];
		}
		
		public function decodeXML(xml:XML):void
		{
			
		}
		
		public function encodeXML():XML
		{
			return <type></type>;
		}
		
		public function clone():ICardType
		{
			return null;
		}
		
	}
}
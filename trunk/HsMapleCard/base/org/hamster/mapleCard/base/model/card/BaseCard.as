package org.hamster.mapleCard.base.model.card
{
	import flash.events.EventDispatcher;
	
	import org.hamster.mapleCard.base.model.base.BaseModel;

	public class BaseCard extends BaseModel implements IBaseCard
	{
		public function BaseCard()
		{
		}
		
		public function encode():XML
		{
			return null;
		}
		
		public function decode(xml:XML):void
		{
			
		}
	}
}
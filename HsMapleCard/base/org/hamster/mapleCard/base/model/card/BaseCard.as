package org.hamster.mapleCard.base.model.card
{
	import flash.events.EventDispatcher;

	public class BaseCard extends EventDispatcher implements IBaseCard
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
package org.hamster.mapleCard.base.model.card
{
	public interface IBaseCard
	{
		public function decode(xml:XML):void;
		public function encode():XML;
	}
}
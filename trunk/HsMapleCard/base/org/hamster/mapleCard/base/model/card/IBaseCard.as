package org.hamster.mapleCard.base.model.card
{
	public interface IBaseCard
	{
		function decode(xml:XML):void;
		function encode():XML;
	}
}
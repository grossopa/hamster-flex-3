package org.hamster.mapleCard.management.models
{
	import mx.collections.ArrayCollection;
	
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class CreatureCardProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "creatureCard";
		private var currentIndex:int = 0;
		
		public function CreatureCardProxy()
		{
			super(NAME, new ArrayCollection());
		}
		
		public function addCreatureCard(value:CreatureCard):void
		{
			var existCard:CreatureCard = null;
			for each (var creatureCard:CreatureCard in this.allCards) {
				if (creatureCard.id == value.id) {
					existCard = creatureCard;
					break;
				}
			}
			
			if (existCard != null) {
				existCard.decode(value.encode());
			} else {
				this.allCards.addItem(value);
			}
		}
		
		public function get creatureCard():CreatureCard
		{
			return data[currentIndex] as CreatureCard;
		}
		
		public function get allCards():ArrayCollection
		{
			return data as ArrayCollection;
		}
	}
}
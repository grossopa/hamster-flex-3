package org.hamster.mapleCard.management.models
{
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class CreatureCardProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "creatureCard";
		
		public function CreatureCardProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function get creatureCard():CreatureCard
		{
			return data as CreatureCard;
		}
	}
}
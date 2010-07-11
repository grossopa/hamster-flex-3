package org.hamster.mapleCard.base.model.card
{
	[Bindable]
	public class CreatureCard extends BaseCard
	{
		public var id:String;
		public var name:String;
		public var moveSpeed:Number;
		public var att:Number;
		public var def:Number;
		public var hp:Number;
		public var distance:Number;
		
		override public function decode(xml:XML):void
		{
			this.id = xml.attribute("id");
			this.name = xml.attribute("name");
			this.moveSpeed = xml.attribute("move-speed");
			this.att = xml.attribute("att");
			this.def = xml.attribute("def");
			this.hp = xml.attribute("hp");
			this.distance = xml.attribute("distance");
		}
		
		override public function encode():XML
		{
			var xml:XML = new XML(<creature-card id={id} name={name} 
				move-speed={moveSpeed} att={att} def={def} 
				hp={hp} distance={distance}></creature-card>);
			trace(xml.toString());
			return xml;
		}
	}
}
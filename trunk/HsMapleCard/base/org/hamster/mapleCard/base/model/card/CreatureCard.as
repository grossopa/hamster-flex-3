package org.hamster.mapleCard.base.model.card
{
	[Bindable]
	public class CreatureCard extends BaseCard
	{
		private var _id:String;
		public function set id(value:String):void { _id = value; }
		public function get id():String { return _id; }
		
		public var name:String;
		public var maxMoveSpeed:Number;
		public var maxAtt:Number;
		public var maxDef:Number;
		public var maxDistance:Number;
		
		private var _maxHp:Number;
		
		public function set maxHp(value:Number):void
		{
			_maxHp = value;
		}
		
		public function get maxHp():Number
		{
			return _maxHp;
		}
		
		override public function decode(xml:XML):void
		{
			this.id = xml.attribute("id");
			this.name = xml.attribute("name");
			this.maxMoveSpeed = xml.attribute("move-speed");
			this.maxAtt = xml.attribute("att");
			this.maxDef = xml.attribute("def");
			this.maxHp = xml.attribute("hp");
			this.maxDistance = xml.attribute("distance");
		}
		
		override public function encode():XML
		{
			var xml:XML = new XML(<creature-card id={id} name={name} 
				move-speed={maxMoveSpeed} att={maxAtt} def={maxDef} 
				hp={maxHp} distance={maxDistance}></creature-card>);
			return xml;
		}
	}
}
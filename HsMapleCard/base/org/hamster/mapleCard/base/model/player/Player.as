package org.hamster.mapleCard.base.model.player
{
	public class Player
	{
		public var id:String;
		public var name:String;
		public var hp:int;
		public var mp:int;
		public var creatures:Array;
		
		public function Player():void
		{
			creatures = [];
		}
	}
}
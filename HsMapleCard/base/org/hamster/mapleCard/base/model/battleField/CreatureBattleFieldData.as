package org.hamster.mapleCard.base.model.battleField
{
	import org.hamster.mapleCard.base.model.IBattleFieldData;
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	
	public class CreatureBattleFieldData extends CreatureCard implements IBattleFieldData
	{
		private var _hp:Number;
		private var _status:String;
		private var _actionProgress:Number;
		
		public function CreatureBattleFieldData()
		{
			super();
		}
		
		public function set hp(value:Number):void
		{
			_hp = value;
		}
		
		public function get hp():Number
		{
			return _hp;
		}
		
		public function set status(value:String):void
		{
			_status = value;
		}
		
		public function get status():String
		{
			return _status;
		}
		
		public function set actionProgress(value:Number):void
		{
			_actionProgress = value;
		}
		
		public function get actionProgress():Number
		{
			return _actionProgress;
		}
	}
}
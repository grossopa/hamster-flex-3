package org.hamster.mapleCard.base.model.battleField
{
	import org.hamster.mapleCard.base.event.BattleFieldDataEvent;
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
			if (_hp != value) {
				var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.HP_CHANGED);
				disEvt.oldValue = _hp;
				_hp = value;
				disEvt.newValue = _hp;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get hp():Number
		{
			return _hp;
		}
		
		public function set status(value:String):void
		{
			if (_status != value) {
				var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.STATUS_CHANGED);
				disEvt.oldValue = _status;
				_status = value;
				disEvt.newValue = _status;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get status():String
		{
			return _status;
		}
		
		public function set actionProgress(value:Number):void
		{
			if (_actionProgress != value) {
				var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.ACTIONPROGRESS_CHANGED);
				disEvt.oldValue = _actionProgress;
				_actionProgress = value;
				disEvt.newValue = _actionProgress;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get actionProgress():Number
		{
			return _actionProgress;
		}
	}
}
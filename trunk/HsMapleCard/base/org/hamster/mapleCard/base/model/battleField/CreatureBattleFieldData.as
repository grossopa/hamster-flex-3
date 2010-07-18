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
		private var _xIndex:int;
		private var _yIndex:int;
		
		public function CreatureBattleFieldData()
		{
			super();
		}
		
		public function set hp(value:Number):void
		{
			if (_hp != value) {
				if (hasEventListener(BattleFieldDataEvent.HP_CHANGED)) {
					var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.HP_CHANGED);
					disEvt.oldValue = _hp;
					_hp = value;
					disEvt.newValue = _hp;
					this.dispatchEvent(disEvt);
				} else {
					_hp = value;
				}
			}
		}
		
		public function get hp():Number
		{
			return _hp;
		}
		
		public function set status(value:String):void
		{
			if (_status != value) {
				if (hasEventListener(BattleFieldDataEvent.STATUS_CHANGED)) {
					var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.STATUS_CHANGED);
					disEvt.oldValue = _status;
					_status = value;
					disEvt.newValue = _status;
					this.dispatchEvent(disEvt);
				} else {
					_status = value;
				}
			}
		}
		
		public function get status():String
		{
			return _status;
		}
		
		public function set actionProgress(value:Number):void
		{
			if (_actionProgress != value) {
				if (hasEventListener(BattleFieldDataEvent.ACTIONPROGRESS_CHANGED)) {
					var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.ACTIONPROGRESS_CHANGED);
					disEvt.oldValue = _actionProgress;
					_actionProgress = value;
					disEvt.newValue = _actionProgress;
					this.dispatchEvent(disEvt);
				} else {
					_actionProgress = value;
				}
			}
		}
		
		public function get actionProgress():Number
		{
			return _actionProgress;
		}
		
		public function set xIndex(value:int):void
		{
			if (_xIndex != value) {
				if (hasEventListener(BattleFieldDataEvent.INDEX_CHANGED)) {
					var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.INDEX_CHANGED);
					disEvt.oldXIndex = _xIndex;
					disEvt.oldYIndex = _yIndex;
					_xIndex = value;
					disEvt.newXIndex = _xIndex;
					disEvt.newYIndex = _yIndex;
					this.dispatchEvent(disEvt);
				} else {
					_xIndex = value;
				}
			}
		}
		
		public function get xIndex():int
		{
			return _xIndex;
		}
		
		public function set yIndex(value:int):void
		{
			if (_yIndex != value) {
				if (hasEventListener(BattleFieldDataEvent.INDEX_CHANGED)) {
					var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.INDEX_CHANGED);
					disEvt.oldXIndex = _xIndex;
					disEvt.oldYIndex = _yIndex;
					_xIndex = value;
					disEvt.newXIndex = _xIndex;
					disEvt.newYIndex = _yIndex;
					this.dispatchEvent(disEvt);
				} else {
					_yIndex = value;
				}
			}
		}
		
		public function get yIndex():int
		{
			return _yIndex;
		}
		
		public function setIndex(xIdx:int, yIdx:int):void
		{
			if (xIdx != _xIndex || yIdx != _yIndex) {
				if (hasEventListener(BattleFieldDataEvent.INDEX_CHANGED)) {
					var disEvt:BattleFieldDataEvent = new BattleFieldDataEvent(BattleFieldDataEvent.INDEX_CHANGED);
					disEvt.oldXIndex = _xIndex;
					disEvt.oldYIndex = _yIndex;
					_xIndex = xIdx;
					_yIndex = yIdx;
					disEvt.newXIndex = _xIndex;
					disEvt.newYIndex = _yIndex;
					this.dispatchEvent(disEvt);
				} else {
					_xIndex = xIdx;
					_yIndex = yIdx;
				}
			}
		}
	}
}
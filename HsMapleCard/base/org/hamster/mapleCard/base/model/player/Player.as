package org.hamster.mapleCard.base.model.player
{
	import flash.display.Bitmap;
	
	import org.hamster.mapleCard.base.constants.ActionStatus;
	import org.hamster.mapleCard.base.event.ActionStackItemDataEvent;
	import org.hamster.mapleCard.base.event.BattleFieldItemDataEvent;
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	import org.hamster.mapleCard.base.model.base.BaseModel;

	[Event(name="hpChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	[Event(name="statusChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	[Event(name="indexChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	
	[Event(name="actionprogressChanged", type="org.hamster.mapleCard.base.event.ActionStackItemDataEvent")]
	
	public class Player extends BaseModel implements IBattleFieldItemData
	{
		private var _hp:Number;
		private var _moveSpeed:Number;
		
		private var _status:String;
		private var _actionStatus:String = ActionStatus.MOVING;
		private var _actionProgress:Number = 0;
		private var _xIndex:int;
		private var _yIndex:int;
		private var _icon:Bitmap;
		private var _parentPlayer:Player;
		private var _maxHp:Number;
		private var _direction:String;
		
		public var name:String;
		public var color:Number;
		public var creatures:Array;
		
		public function set moveSpeed(value:Number):void { _moveSpeed = value }
		public function get moveSpeed():Number { return _moveSpeed }
		
		public function set direction(value:String):void
		{
			this._direction = value;
		}
		
		public function get direction():String
		{
			return this._direction;
		}
		
		public function Player():void
		{
			creatures = [];
		}
		
		public function set hp(value:Number):void
		{
			if (_hp != value) {
				if (hasEventListener(BattleFieldItemDataEvent.HP_CHANGED)) {
					var disEvt:BattleFieldItemDataEvent = new BattleFieldItemDataEvent(BattleFieldItemDataEvent.HP_CHANGED);
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
				if (hasEventListener(BattleFieldItemDataEvent.STATUS_CHANGED)) {
					var disEvt:BattleFieldItemDataEvent = new BattleFieldItemDataEvent(BattleFieldItemDataEvent.STATUS_CHANGED);
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
		
		public function set actionStatus(value:String):void
		{
			if (_actionStatus != value) {
				if (hasEventListener(ActionStackItemDataEvent.ACTIONPSTATUS_CHANGED)) {
					var disEvt:ActionStackItemDataEvent = new ActionStackItemDataEvent(ActionStackItemDataEvent.ACTIONPSTATUS_CHANGED);
					disEvt.oldValue = _actionStatus;
					_actionStatus = value;
					disEvt.newValue = _actionStatus;
					this.dispatchEvent(disEvt);
				} else {
					_actionStatus = value;
				}
			}
		}
		
		public function get actionStatus():String
		{
			return _actionStatus;
		}
		
		public function set actionProgress(value:Number):void
		{
			if (_actionProgress != value) {
				if (hasEventListener(ActionStackItemDataEvent.ACTIONPROGRESS_CHANGED)) {
					var disEvt:ActionStackItemDataEvent = new ActionStackItemDataEvent(ActionStackItemDataEvent.ACTIONPROGRESS_CHANGED);
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
				if (hasEventListener(BattleFieldItemDataEvent.INDEX_CHANGED)) {
					var disEvt:BattleFieldItemDataEvent = new BattleFieldItemDataEvent(BattleFieldItemDataEvent.INDEX_CHANGED);
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
				if (hasEventListener(BattleFieldItemDataEvent.INDEX_CHANGED)) {
					var disEvt:BattleFieldItemDataEvent = new BattleFieldItemDataEvent(BattleFieldItemDataEvent.INDEX_CHANGED);
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
				if (hasEventListener(BattleFieldItemDataEvent.INDEX_CHANGED)) {
					var disEvt:BattleFieldItemDataEvent = new BattleFieldItemDataEvent(BattleFieldItemDataEvent.INDEX_CHANGED);
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
		
		public function set actionStackIcon(value:Bitmap):void
		{
			this._icon = value;
		}
		
		public function get actionStackIcon():Bitmap
		{
			return _icon;
		}
		
		public function set maxHp(value:Number):void
		{
			_maxHp = value;
		}
		
		public function get maxHp():Number
		{
			return _maxHp;
		}
		
		public function set parentPlayer(value:Player):void
		{
			
		}
		
		public function get parentPlayer():Player
		{
			return this;
		}
		
		
	}
}
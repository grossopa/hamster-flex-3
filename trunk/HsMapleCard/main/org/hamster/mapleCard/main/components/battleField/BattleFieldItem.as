package org.hamster.mapleCard.main.components.battleField
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.hamster.mapleCard.assets.style.BattleFieldItemStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.components.images.BaseImage;
	import org.hamster.mapleCard.base.event.BattleFieldDataEvent;
	import org.hamster.mapleCard.base.model.IBattleFieldData;
	
	[Event(name="hpChanged", type="org.hamster.mapleCard.base.event.BattleFieldDataEvent")]
	[Event(name="statusChanged", type="org.hamster.mapleCard.base.event.BattleFieldDataEvent")]
	[Event(name="actionprogressChanged", type="org.hamster.mapleCard.base.event.BattleFieldDataEvent")]
	[Event(name="indexChanged", type="org.hamster.mapleCard.base.event.BattleFieldDataEvent")]
	
	public class BattleFieldItem extends SimpleContainer
	{
		protected var _battleFieldData:IBattleFieldData;
		
		public function set battleFieldData(value:IBattleFieldData):void
		{
			if (_battleFieldData != null) {
				this.removeBattleFieldDataListener(_battleFieldData);
			}
			_battleFieldData = value;
			this.addBattleFieldDataListener(_battleFieldData);
		}
		
		public function get battleFieldData():IBattleFieldData
		{
			return _battleFieldData;
		}
		
		protected var _mainImage:BaseImage;
		protected var _lifeBar:Sprite;
		
		protected var _isRedrawLifeBar:Boolean = true;
		
		public function set mainImage(value:BaseImage):void
		{
			this._mainImage = value;
		}
		
		public function get mainImage():BaseImage
		{
			return this._mainImage;
		}
		
		public function BattleFieldItem()
		{
			super();
			this._measuredWidth = BattleFieldItemStyle.WIDTH;
			this._measuredHeight = BattleFieldItemStyle.HEIGHT;
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		override protected function addedHandler(evt:Event):void
		{
			if (this.numChildren == 0) {
				this._lifeBar = new Sprite();
				this.addChild(this._lifeBar);
				this._lifeBar.y = 15;
				this._lifeBar.x = 10;
				
				if (this._mainImage != null) {
					this.addChild(this._mainImage);
				}
			}
		}
		
		protected function onEnterFrameHandler(ect:Event):void
		{
			this._mainImage.x = (this._measuredWidth - this._mainImage.measuredWidth) / 2;
			this._mainImage.y = this._measuredHeight - this._mainImage.measuredHeight - 30;
			
			if (this._battleFieldData != null && _isRedrawLifeBar) {
				drawLifeBar();
				_isRedrawLifeBar = false;
			}
		}
		
		protected function drawLifeBar():void
		{
			var g:Graphics = this._lifeBar.graphics;
			g.clear();
			g.lineStyle(0.5, 0, 0.5);
			g.beginFill(BattleFieldItemStyle.LIFE_BAR_COLOR, 1);
			var w:Number = BattleFieldItemStyle.LIFE_BAR_WIDTH * (this._battleFieldData.hp / this._battleFieldData.maxHp);
			g.drawRect(0, 0, w, BattleFieldItemStyle.LIFE_BAR_HEIGHT);
			g.endFill();
			
			g.beginFill(BattleFieldItemStyle.LIFE_BAR_BG_COLOR, 1);
			g.drawRect(w, 0, BattleFieldItemStyle.LIFE_BAR_WIDTH - w, BattleFieldItemStyle.LIFE_BAR_HEIGHT);
			g.endFill();
			
			this._lifeBar.width = BattleFieldItemStyle.LIFE_BAR_WIDTH;
			this._lifeBar.height = BattleFieldItemStyle.LIFE_BAR_HEIGHT;
		}
		
		protected function hpChangedHandler(evt:BattleFieldDataEvent):void
		{
			_isRedrawLifeBar = true;
			this.dispatchEvent(evt);
		}
		
		protected function statusChangedHandler(evt:BattleFieldDataEvent):void
		{
			this.dispatchEvent(evt);
		}
		
		protected function actionProgressChangedHandler(evt:BattleFieldDataEvent):void
		{
			this.dispatchEvent(evt);
		}
		
		protected function indexChangedHandler(evt:BattleFieldDataEvent):void
		{
			this.dispatchEvent(evt);
		}
		
		protected function addBattleFieldDataListener(obj:IBattleFieldData):void
		{
			obj.addEventListener(BattleFieldDataEvent.HP_CHANGED, hpChangedHandler);
			obj.addEventListener(BattleFieldDataEvent.STATUS_CHANGED, statusChangedHandler);
			obj.addEventListener(BattleFieldDataEvent.ACTIONPROGRESS_CHANGED, actionProgressChangedHandler);
			obj.addEventListener(BattleFieldDataEvent.INDEX_CHANGED, indexChangedHandler);
		}
		
		protected function removeBattleFieldDataListener(obj:IBattleFieldData):void
		{
			obj.removeEventListener(BattleFieldDataEvent.HP_CHANGED, hpChangedHandler);
			obj.removeEventListener(BattleFieldDataEvent.STATUS_CHANGED, statusChangedHandler);
			obj.removeEventListener(BattleFieldDataEvent.ACTIONPROGRESS_CHANGED, actionProgressChangedHandler);
			obj.removeEventListener(BattleFieldDataEvent.INDEX_CHANGED, indexChangedHandler);
		}
	}
}
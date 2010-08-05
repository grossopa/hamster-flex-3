package org.hamster.mapleCard.main.components.battleField
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.hamster.mapleCard.assets.style.BattleFieldItemStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.components.images.BaseImage;
	import org.hamster.mapleCard.base.components.images.CreatureImage;
	import org.hamster.mapleCard.base.constants.Constants;
	import org.hamster.mapleCard.base.event.ActionStackItemDataEvent;
	import org.hamster.mapleCard.base.event.BattleFieldItemDataEvent;
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	
	[Event(name="hpChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	[Event(name="statusChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	[Event(name="actionprogressChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	[Event(name="indexChanged", type="org.hamster.mapleCard.base.event.BattleFieldItemDataEvent")]
	
	public class BattleFieldItem extends SimpleContainer
	{
		protected var _battleFieldData:IBattleFieldItemData;
		
		public function set battleFieldData(value:IBattleFieldItemData):void
		{
			if (_battleFieldData != null) {
				this.removeBattleFieldDataListener(_battleFieldData);
				this.removeChild(_mainImage);
			}
			_battleFieldData = value;
			this.addBattleFieldDataListener(_battleFieldData);
			initMainImage();
		}
		
		public function get battleFieldData():IBattleFieldItemData
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
		
		override protected function addedToStageHandler(evt:Event):void
		{
			super.addedToStageHandler(evt);
			
			if (this._lifeBar == null) {
				this._lifeBar = new Sprite();
				this.addChild(this._lifeBar);
				this._lifeBar.y = 15;
				this._lifeBar.x = 10;
			}
		}
		
		protected function initMainImage():void
		{
			if (this._battleFieldData.id.indexOf(Constants.CREATE_KEY_PREFIX) >= 0) {
				this._mainImage = new CreatureImage(this._battleFieldData.id.replace(Constants.CREATE_KEY_PREFIX, ""));
				this._mainImage.direction = this._battleFieldData.direction;
				this.addChild(_mainImage);
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
		
		protected function hpChangedHandler(evt:BattleFieldItemDataEvent):void
		{
			_isRedrawLifeBar = true;
			this.dispatchEvent(evt);
		}
		
		protected function statusChangedHandler(evt:BattleFieldItemDataEvent):void
		{
			this.dispatchEvent(evt);
		}
		
		protected function actionProgressChangedHandler(evt:ActionStackItemDataEvent):void
		{
			this.dispatchEvent(evt);
		}
		
		protected function indexChangedHandler(evt:BattleFieldItemDataEvent):void
		{
			this.dispatchEvent(evt);
		}
		
		protected function addBattleFieldDataListener(obj:IBattleFieldItemData):void
		{
			obj.addEventListener(BattleFieldItemDataEvent.HP_CHANGED, hpChangedHandler);
			obj.addEventListener(BattleFieldItemDataEvent.STATUS_CHANGED, statusChangedHandler);
			obj.addEventListener(ActionStackItemDataEvent.ACTIONPROGRESS_CHANGED, actionProgressChangedHandler);
			obj.addEventListener(BattleFieldItemDataEvent.INDEX_CHANGED, indexChangedHandler);
		}
		
		protected function removeBattleFieldDataListener(obj:IBattleFieldItemData):void
		{
			obj.removeEventListener(BattleFieldItemDataEvent.HP_CHANGED, hpChangedHandler);
			obj.removeEventListener(BattleFieldItemDataEvent.STATUS_CHANGED, statusChangedHandler);
			obj.removeEventListener(ActionStackItemDataEvent.ACTIONPROGRESS_CHANGED, actionProgressChangedHandler);
			obj.removeEventListener(BattleFieldItemDataEvent.INDEX_CHANGED, indexChangedHandler);
		}
	}
}
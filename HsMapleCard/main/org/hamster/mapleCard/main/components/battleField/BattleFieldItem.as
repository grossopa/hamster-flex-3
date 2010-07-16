package org.hamster.mapleCard.main.components.battleField
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	
	public class BattleFieldItem extends SimpleContainer
	{
		protected var _mainImage:Sprite;
		protected var _lifeBar:Sprite;
		
		public function BattleFieldItem()
		{
			super();
			
			this._measuredWidth = 100;
			this._measuredHeight = 75;
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		override protected function addedHandler(evt:Event):void
		{
			if (this.numChildren == 0) {
				this._lifeBar = new Sprite();
				this._lifeBar.width = 80;
				this._lifeBar.height = 5;
				this._lifeBar.y = 10;
				this._lifeBar.x = 10;
				this.addChild(this._lifeBar);
				
				if (this._mainImage != null) {
					this.addChild(this._mainImage);
				}
			}
		}
		
		protected function onEnterFrameHandler(ect:Event):void
		{
			this._mainImage.x = (this._measuredWidth - this._mainImage) / 2;
			this._mainImage.y = this._measuredHeight - this._mainImage.height - 10;
		}
	}
}
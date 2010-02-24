package org.hamster.magic.common.controls.units
{
	import flash.filters.GlowFilter;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.ScrollPolicy;
	
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.services.AssetService;

	public class CardUnit extends Canvas
	{
		protected static const AS:AssetService = AssetService.getInstance();
		protected var _glowFilterInner:GlowFilter = new GlowFilter(0xFFFFFF, 0.5, 3, 3, 2, 3);
		
		private var _card:Card;
		private var _selected:Boolean;
		
		protected var _mainImage:Image;
		
		public function set card(value:Card):void
		{
			this._card = value;
			if (this.initialized) {
				this._mainImage.source = this.source;
			}
		}
		
		public function get card():Card
		{
			return this._card;
		}
		
		public function set selected(value:Boolean):void
		{
			this._selected = value;
			
			if (this.selected) {
				this.filters = [_glowFilterInner];
			} else {
				this.filters = [];
			}
		}
		
		public function get selected():Boolean
		{
			return this._selected;
		}
		
		protected function get source():Object
		{
			if (this.card == null) {
				return AS.CARD_BACK;
			} else {
				return this.card.imgPath;
			}
		}
		
		public function CardUnit()
		{
			super();
			
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			this.verticalScrollPolicy = ScrollPolicy.OFF;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_mainImage = new Image();
			_mainImage.percentWidth = 100;
			_mainImage.percentHeight = 100;
			_mainImage.maintainAspectRatio = false;
			_mainImage.setStyle("verticalAlign", "middle");
			_mainImage.setStyle("horizontalAlign", "center");
			_mainImage.source = this.source;
			this.addChild(_mainImage);
		}
		
		
	}
}
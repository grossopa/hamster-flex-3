package org.hamster.magic.common.controls.units
{
	import flash.filters.GlowFilter;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.ScrollPolicy;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.services.AssetService;

	public class CardUnit extends Canvas
	{
		protected static const AS:AssetService = AssetService.getInstance();
		protected var _glowFilterInner:GlowFilter = new GlowFilter(0xFFFFFF, 0.5, 3, 3, 2, 3);
		
		private var _card:Card;
		private var _selected:Boolean;
		
		private var _mainImage:Image;
		
		override public function set data(value:Object):void
		{
			super.data = value;
			this.card = Card(value);
		}
		
		protected function get mainImage():Image
		{
			return this._mainImage;
		}
		
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
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_mainImage = new Image();
			_mainImage.percentWidth = 100;
			_mainImage.percentHeight = 100;
			_mainImage.maintainAspectRatio = true;
			_mainImage.setStyle("verticalAlign", "middle");
			_mainImage.setStyle("horizontalAlign", "center");
			_mainImage.source = this.source;
			this.addChild(_mainImage);
		}
		
		protected function completeHandler(evt:FlexEvent):void
		{
			this.mainImage.source = this.source;
		}
		
	}
}
package org.hamster.magic.common.controls.units
{
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.ScrollPolicy;
	
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.services.AssetService;

	public class CardUnit extends Canvas
	{
		protected static const AS:AssetService = AssetService.getInstance();
		
		private var _card:Card;
		
		protected var _mainImage:Image;
		
		public function set card(value:Card):void
		{
			this._card = value;
		}
		
		public function get card():Card
		{
			return this._card;
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
			_mainImage.cachePolicy = "on";
			_mainImage.maintainAspectRatio = true;
			_mainImage.setStyle("verticalAlign", "middle");
			_mainImage.setStyle("horizontalAlign", "center");
			_mainImage.source = this.source;
			this.addChild(_mainImage);
		}
		
		
	}
}
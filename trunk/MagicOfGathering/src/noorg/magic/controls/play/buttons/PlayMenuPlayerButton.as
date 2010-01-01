package noorg.magic.controls.play.buttons
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	
	import mx.events.FlexEvent;
	
	import noorg.magic.controls.common.buttons.base.BaseSimpleButton;
	import noorg.magic.models.Player;

	public class PlayMenuPlayerButton extends BaseSimpleButton
	{
		[Embed(source='/noorg/magic/assets/icons/playMenu/player_down.png')]
		private var DOWN_PNG:Class;
		[Embed(source='/noorg/magic/assets/icons/playMenu/player_normal.png')]
		private var NORMAL_PNG:Class;
		[Embed(source='/noorg/magic/assets/icons/playMenu/player_over.png')]
		private var OVER_PNG:Class;			

		public function set player(value:Player):void {
			var bm:BitmapData = new BitmapData(this.width, this.height, false, value.color);
			bm.draw(this._overImage, null, null, BlendMode.ALPHA);
			this._overImage.bitmapData.draw(bm, null, null, BlendMode.OVERLAY);
			this._normalImage.bitmapData.draw(bm, null, null, BlendMode.OVERLAY);
			this._downImage.bitmapData.draw(bm, null, null, BlendMode.OVERLAY);
			this.invalidateDisplayList();			
		}

		public function PlayMenuPlayerButton()
		{
			super();
			
			this.width = 35;
			this.height = 35;
			
			this.overImage 		= OVER_PNG;
			this.downImage 		= DOWN_PNG;
			this.normalImage 	= NORMAL_PNG;
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
		}
		
		private function completeHandler(evt:FlexEvent):void
		{
			this.removeEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
	
		}
		
	}
}
package noorg.magic.controls.play.unit
{
	import mx.containers.HBox;
	
	import noorg.magic.controls.unit.CardUnit;
	import noorg.magic.utils.Constants;

	public class PlayCardUnit extends CardUnit
	{
		private var _child_hBox:HBox;
		
		public function PlayCardUnit()
		{
			super();
			this.width = Constants.CARD_WIDTH;
			this.height = Constants.CARD_HEIGHT;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			
		}
		
	}
}
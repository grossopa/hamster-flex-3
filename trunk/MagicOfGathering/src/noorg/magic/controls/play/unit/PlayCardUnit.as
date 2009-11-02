package noorg.magic.controls.play.unit
{
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import noorg.magic.controls.unit.CardUnit;
	import noorg.magic.models.Card;
	import noorg.magic.utils.Constants;

	public class PlayCardUnit extends CardUnit
	{
		private var _child_hBox:HBox;
		
		override public function set data(value:Object):void
		{
			this.card = Card(value);
		}
		
		override public function get data():Object
		{
			return this.card;
		}
		
		public function PlayCardUnit()
		{
			super();
			this.width = Constants.PLAY_CARD_WIDTH;
			this.height = Constants.PLAY_CARD_HEIGHT;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function mouseDownHandler(evt:MouseEvent):void
		{
			var ds:DragSource = new DragSource();
			ds.addData({"x":evt.localX, "y":evt.localY}, "xy");
			DragManager.doDrag(this, ds, evt, this);
		}
		
		
	}
}
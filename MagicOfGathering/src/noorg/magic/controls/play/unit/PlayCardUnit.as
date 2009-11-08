package noorg.magic.controls.play.unit
{
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import noorg.magic.controls.unit.CardUnit;
	import noorg.magic.events.PlayCardDragEvent;
	import noorg.magic.models.PlayCard;
	import noorg.magic.utils.Constants;
	
	import org.hamster.utils.ImageUtil;

	public class PlayCardUnit extends CardUnit
	{
		private var _child_hBox:HBox;
		
		override public function set data(value:Object):void
		{
			this.card = PlayCard(value);
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
			this.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
			this.addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
		}
		
		private function mouseDownHandler(evt:MouseEvent):void
		{
			var ds:DragSource = new DragSource();
			ds.addData({"x":evt.localX, "y":evt.localY}, "xy");
			var snapshot:Image = ImageUtil.toImage(mainImage, true);
			DragManager.doDrag(this, ds, evt, snapshot);
		}
		
		private function dragEnterHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit) {
				DragManager.acceptDragDrop(this);
				var disEvt:PlayCardDragEvent = new PlayCardDragEvent(PlayCardDragEvent.DRAG_ENTER, true);
				disEvt.enterLeftSide = evt.localX <= this.width;
				disEvt.playCard = PlayCard(this.card);
				this.dispatchEvent(disEvt);
			}
		}
		
		private function dragDropHandler(evt:DragEvent):void
		{
			var disEvt:PlayCardDragEvent = new PlayCardDragEvent(PlayCardDragEvent.DRAG_DROP, true);
			disEvt.enterLeftSide = evt.localX <= this.width;
			disEvt.playCard = PlayCard(this.card);
			this.dispatchEvent(disEvt);			
		}
		
		
	}
}
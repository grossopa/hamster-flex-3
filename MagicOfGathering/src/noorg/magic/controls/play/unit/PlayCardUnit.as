package noorg.magic.controls.play.unit
{
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import noorg.magic.controls.icons.IconDetail;
	import noorg.magic.controls.icons.IconTag;
	import noorg.magic.controls.unit.CardUnit;
	import noorg.magic.events.PlayCardDragEvent;
	import noorg.magic.events.PlayCardEvent;
	import noorg.magic.models.Card;
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.staticValue.CardStatus;
	import noorg.magic.utils.Constants;
	import noorg.magic.utils.GlobalUtil;
	
	import org.hamster.utils.ImageUtil;

	public class PlayCardUnit extends CardUnit
	{
		
		private var iconDetail:IconDetail;
		private var iconTag:IconTag;
			
		override public function set card(value:Card):void
		{
			if (super.card != null) {
				super.card.removeEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
			}
			super.card = PlayCard(value);
			super.card.addEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
		}
		
		public function PlayCardUnit()
		{
			super();
			this.width = Constants.PLAY_CARD_WIDTH;
			this.height = Constants.PLAY_CARD_HEIGHT;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		//	this.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
		//	this.addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			iconDetail = new IconDetail();
			iconDetail.x = 2;
			iconDetail.y = 2;
			iconDetail.addEventListener(MouseEvent.CLICK, detailClickHandler);
			this.addChild(iconDetail);
			
			iconTag = new IconTag();
			iconTag.x = 4 + Constants.ICON_WIDTH;
			iconTag.y = 2;
			iconTag.addEventListener(MouseEvent.CLICK, tagClickHandler);
			this.addChild(iconTag);
		}
		
		private function detailClickHandler(evt:MouseEvent):void
		{
			//var disEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.SHOW_DETAIL, true);
			//disEvt.card = PlayCard(this.card);
			//this.dispatchEvent(disEvt);
			
			GlobalUtil.showDetailPopup(PlayCard(this.card));
		}
		
		private function tagClickHandler(evt:MouseEvent):void
		{
			var playCard:PlayCard = PlayCard(this.card);
			if (playCard.status != CardStatus.PLAY_TAGGED) {
				playCard.status = CardStatus.PLAY_TAGGED;
			} else {
				playCard.status = CardStatus.PLAY;
			}
		}
		
		private function statusChangedHandler(evt:PlayCardEvent):void
		{
			if (evt.newStatus == CardStatus.PLAY_TAGGED) {
				this.iconTag.alpha = 0.5;
				this.alpha = 0.5;
			} else {
				this.iconTag.alpha = 1;
				this.alpha = 1;
			}
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
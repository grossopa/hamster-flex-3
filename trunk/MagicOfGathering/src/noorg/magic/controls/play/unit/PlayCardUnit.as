package noorg.magic.controls.play.unit
{
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import noorg.magic.controls.icons.IconDetail;
	import noorg.magic.controls.icons.IconManager;
	import noorg.magic.controls.icons.IconTap;
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
		protected const iconManager:IconManager = new IconManager();
		protected var iconDetail:IconDetail;
		protected var iconTap:IconTap;
			
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
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		//	this.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
		//	this.addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			createIcon();
		}
		
		protected function createIcon():void
		{
			iconDetail = new IconDetail();
			iconDetail.visible = false;
			iconDetail.addEventListener(MouseEvent.CLICK, detailClickHandler);
			this.addChild(iconDetail);
			
			iconTap = new IconTap();
			iconTap.visible = false;
			iconTap.addEventListener(MouseEvent.CLICK, tapClickHandler);
			this.addChild(iconTap);
			
			this.iconManager.iconArrColl.addItem(iconDetail);
			this.iconManager.iconArrColl.addItem(iconTap);
			this.iconManager.refreshLocation();
		}
		
		private function detailClickHandler(evt:MouseEvent):void
		{
			//var disEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.SHOW_DETAIL, true);
			//disEvt.card = PlayCard(this.card);
			//this.dispatchEvent(disEvt);
			
			GlobalUtil.showDetailPopup(PlayCard(this.card));
		}
		
		private function tapClickHandler(evt:MouseEvent):void
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
				this.width = Constants.PLAY_CARD_HEIGHT;
				this.mainImage.width = this.width;
				this.mainImage.validateNow();
				this.mainImage.rotation = 90;
				this.mainImage.x = Constants.PLAY_CARD_HEIGHT;
			} else {
				this.width = Constants.PLAY_CARD_WIDTH;
				this.mainImage.width = this.width;
				this.mainImage.rotation = 0;
				this.mainImage.x = 0;
			}
		}
		
		private function mouseDownHandler(evt:MouseEvent):void
		{
			var ds:DragSource = new DragSource();
			ds.addData({"x":evt.localX, "y":evt.localY}, "xy");
			var snapshot:Image = ImageUtil.toImage(mainImage, true);
			DragManager.doDrag(this, ds, evt, snapshot);
		}
		
		private function rollOverHandler(evt:MouseEvent):void
		{
			this.iconManager.showIcon();
		}
		
		private function rollOutHandler(evt:MouseEvent):void
		{
			this.iconManager.hideIcon();
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
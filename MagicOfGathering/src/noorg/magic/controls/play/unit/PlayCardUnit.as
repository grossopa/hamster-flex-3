package noorg.magic.controls.play.unit
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.DragSource;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.managers.DragManager;
	
	import noorg.magic.controls.icons.IconCardQuickMenu;
	import noorg.magic.controls.icons.IconCast;
	import noorg.magic.controls.icons.IconEnhancement;
	import noorg.magic.controls.icons.IconManager;
	import noorg.magic.controls.icons.IconTap;
	import noorg.magic.controls.masks.drag.DragMaskEnhancement;
	import noorg.magic.controls.masks.drag.DragMaskInsertArrow;
	import noorg.magic.controls.masks.drag.DragMaskManager;
	import noorg.magic.controls.unit.CardUnit;
	import noorg.magic.events.PlayCardEvent;
	import noorg.magic.models.Card;
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	import noorg.magic.models.staticValue.CardLocation;
	import noorg.magic.models.staticValue.CardStatus;
	import noorg.magic.services.MenuService;
	import noorg.magic.utils.Constants;
	import noorg.magic.utils.GlobalUtil;

	public class PlayCardUnit extends CardUnit
	{
		public static const menuService:MenuService = MenuService.getInstance();
		
		protected const iconManager:IconManager = new IconManager();
		protected const dragMaskManager:DragMaskManager = new DragMaskManager();
		
	//	protected var iconDetail:IconDetail;
		protected var iconCast:IconCast;
		protected var iconTap:IconTap;
		protected var iconEnhancement:IconEnhancement;
		
		protected var iconQuickMenu:IconCardQuickMenu;
		
		protected var dragMaskEnhancement:DragMaskEnhancement;
		protected var dragMaskInsertLeft:DragMaskInsertArrow;
		protected var dragMaskInsertRight:DragMaskInsertArrow;
		
		public var dragEnabled:Boolean = true;
		
		override public function set data(value:Object):void
		{
			this.card = PlayCard(value);
		}
		
		override public function get data():Object
		{
			return this.card;
		}
		
		override public function set card(value:Card):void
		{
			if (super.card != null) {
				super.card.removeEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
				super.card.removeEventListener(PlayCardEvent.POOL_ENOUGH_STATUS_CHANGE, poolEnoughStatusChangeHandler);
				super.card.removeEventListener(PlayCardEvent.LOCATION_CHANGED, locationChangedHandler);
			}
			super.card = PlayCard(value);
			super.card.addEventListener(PlayCardEvent.STATUS_CHANGED, statusChangedHandler);
			super.card.addEventListener(PlayCardEvent.POOL_ENOUGH_STATUS_CHANGE, poolEnoughStatusChangeHandler);
			super.card.addEventListener(PlayCardEvent.LOCATION_CHANGED, locationChangedHandler);
		}
		
		public function get playCard():PlayCard
		{
			return PlayCard(this.card);
		}
		
		public function get player():Player
		{
			return this.playCard.player;
		}
		
		public function PlayCardUnit()
		{
			super();
			this.width = Constants.PLAY_CARD_WIDTH;
			this.height = Constants.PLAY_CARD_HEIGHT;
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			this.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
			this.addEventListener(DragEvent.DRAG_EXIT, dragExitHandler);
			this.addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			createDragMask();
			createIcon();
			
			this.mainImage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			this.mainImageOverlay.visible = true;
		}
		
		protected function creationCompleteHandler(evt:FlexEvent):void
		{
			this.removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		protected function createDragMask():void
		{
			dragMaskEnhancement = new DragMaskEnhancement();
			dragMaskEnhancement.visible = false;
			dragMaskEnhancement.addEventListener(DragEvent.DRAG_DROP, maskEnhancementDragDropHandler);
			addChild(dragMaskEnhancement);
			
			dragMaskInsertLeft = new DragMaskInsertArrow();
			dragMaskInsertLeft.visible = false;
			dragMaskInsertLeft.isLeft = true;
			dragMaskInsertLeft.x = 0;
			dragMaskInsertLeft.y = Constants.DRAG_MASK_HEIGHT;
			dragMaskInsertLeft.addEventListener(DragEvent.DRAG_DROP, maskLeftDragDropHandler);
			addChild(dragMaskInsertLeft);
			
			dragMaskInsertRight = new DragMaskInsertArrow();
			dragMaskInsertRight.visible = false;
			dragMaskInsertRight.isLeft = false;
			dragMaskInsertRight.x = Constants.DRAG_MASK_WIDTH * 2;
			dragMaskInsertRight.y = Constants.DRAG_MASK_HEIGHT;
			dragMaskInsertRight.addEventListener(DragEvent.DRAG_DROP, maskRightDragDropHandler);
			addChild(dragMaskInsertRight);
			
			dragMaskManager.maskColl.addItem(dragMaskEnhancement);
			dragMaskManager.maskColl.addItem(dragMaskInsertLeft);
			dragMaskManager.maskColl.addItem(dragMaskInsertRight);
		}
		
		protected function createIcon():void
		{
//			iconDetail = new IconDetail();
//			iconDetail.visible = false;
//			iconDetail.addEventListener(MouseEvent.CLICK, detailClickHandler);
//			this.addChild(iconDetail);

			iconCast = new IconCast();
			iconCast.visible = false;
			iconCast.addEventListener(MouseEvent.CLICK, castClickHandler);
			this.addChild(iconCast);
			
			iconTap = new IconTap();
			iconTap.visible = false;
			iconTap.addEventListener(MouseEvent.CLICK, tapClickHandler);
			this.addChild(iconTap);
			
			iconEnhancement = new IconEnhancement();
			iconEnhancement.visible = false;
			iconEnhancement.addEventListener(MouseEvent.CLICK, enhancementClickHandler);
			this.addChild(iconEnhancement);
			
			iconQuickMenu = new IconCardQuickMenu();
			iconQuickMenu.visible = false;
			iconQuickMenu.x = this.width - iconQuickMenu.width;
			iconQuickMenu.y = this.height - iconQuickMenu.height;
			iconQuickMenu.addEventListener(MouseEvent.CLICK, openQuickMenuHandler);
			this.addChild(iconQuickMenu);
			
			//this.iconManager.iconArrColl.addItem(iconDetail);
			this.iconManager.iconArrColl.addItem(iconCast);
			this.iconManager.iconArrColl.addItem(iconTap);
			this.iconManager.iconArrColl.addItem(iconEnhancement);
			this.iconManager.iconArrColl.addItem(iconQuickMenu);
			
			if (this.playCard != null) {
				locationChangedHandler(null);
			}
			
			this.iconManager.refreshLocation();
		}
		
		private function detailClickHandler(evt:MouseEvent):void
		{
			GlobalUtil.showDetailPopup(PlayCard(this.card));
		}
		
		private function castClickHandler(evt:MouseEvent):void
		{
			this.playCard.cast();
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
		
		private function maskEnhancementDragDropHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit) {
				var unit:PlayCardUnit = PlayCardUnit(evt.dragInitiator);
				this.playCard.enhancementCards.addItem(unit.playCard);
			}			
		}
		
		private function openQuickMenuHandler(evt:MouseEvent):void
		{
			var pos:Point = this.localToGlobal(new Point());
			menuService.showPlayCardMenu(this, pos.x, pos.y);
		}
		
		private function maskLeftDragDropHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit) {
				var unit:PlayCardUnit = PlayCardUnit(evt.dragInitiator);
				var index:int = this.player.playerCardColl.getLocationArray(
						this.playCard.getLocation()).getItemIndex(this.playCard);
				unit.playCard.setLocation(this.playCard.getLocation(), index);
			}
			
		}
		
		private function maskRightDragDropHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit) {
				var unit:PlayCardUnit = PlayCardUnit(evt.dragInitiator);
				var index:int = this.player.playerCardColl.getLocationArray(
						this.playCard.getLocation()).getItemIndex(this.playCard);
				unit.playCard.setLocation(this.playCard.getLocation(), index + 1);
			}			
		}
		
		private function enhancementClickHandler(evt:MouseEvent):void
		{
			GlobalUtil.showEnhancementPopup(this.playCard);
		}
		
		private function statusChangedHandler(evt:PlayCardEvent):void
		{
			if (evt.newStatus == CardStatus.PLAY_TAGGED) {
				this.width = Constants.PLAY_CARD_HEIGHT;
				iconQuickMenu.x = this.width - iconQuickMenu.width;
				iconQuickMenu.y = Constants.PLAY_CARD_WIDTH - iconQuickMenu.height;
				this.mainImage.width = this.height;
				this.mainImage.validateNow();
				this.mainImage.rotation = 90;
				this.mainImage.x = Constants.PLAY_CARD_HEIGHT;
			} else {
				this.width = Constants.PLAY_CARD_WIDTH;
				iconQuickMenu.x = this.width - iconQuickMenu.width;
				iconQuickMenu.y = this.height - iconQuickMenu.height;
				this.mainImage.width = this.width;
				this.mainImage.rotation = 0;
				this.mainImage.x = 0;
			}
			
			this.invalidateDisplayList();
		}
		
		private function locationChangedHandler(evt:PlayCardEvent):void
		{
			if (this.playCard.getLocation() == CardLocation.HAND) {
				this.iconTap.isEnabled = false;
				this.iconEnhancement.isEnabled = false;
				this.iconCast.isEnabled = this.playCard.isPoolEnough;
			} else {
				this.iconTap.isEnabled = true;
				this.iconCast.isEnabled = false;
				this.iconEnhancement.isEnabled = true;
			}
		}
		
		private function poolEnoughStatusChangeHandler(evt:PlayCardEvent):void
		{
			this.invalidateDisplayList();
		}
		
		public function addEnhancementCard(playCard:PlayCard):void
		{
			this.playCard.enhancementCards.addItem(playCard);
		}
		
		private function mouseDownHandler(evt:MouseEvent):void
		{
			if (dragEnabled) {
				var ds:DragSource = new DragSource();
				var p:Point = this.globalToLocal(new Point(evt.stageX, evt.stageY));
				DragManager.doDrag(this, ds, evt, this.mainImage,p.x + 10, p.y - this.height / 2);
			}
		}
		
		private function rollOverHandler(evt:MouseEvent):void
		{
			this.iconManager.refreshLocation();
			this.iconManager.showIcon();
		}
		
		private function rollOutHandler(evt:MouseEvent):void
		{
			this.iconManager.hideIcon();
		}
		
		private function dragEnterHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit && evt.dragInitiator != this) {
				DragManager.acceptDragDrop(this);
				
				this.dragMaskManager.showMask();
				
				var unit:PlayCardUnit = PlayCardUnit(evt.dragInitiator);
				if (unit.player != this.player) {
					this.dragMaskInsertLeft.visible = false;
					this.dragMaskInsertRight.visible = false;
				}
			}
		}
		
		private function dragExitHandler(evt:DragEvent):void
		{
			if (evt.dragInitiator is PlayCardUnit) {
				this.dragMaskManager.hideMask();
			}			
		}
		
		private function dragDropHandler(evt:DragEvent):void
		{
			this.dragMaskManager.hideMask();
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			var g:Graphics = this.mainImageOverlay.graphics;
			
			g.clear();
			if (!this.playCard.isPoolEnough && this.playCard.getLocation() == CardLocation.HAND) {
				g.beginFill(0x000000, 0.5);
				g.drawRect(0, 0, this.mainImageOverlay.width, this.mainImageOverlay.height);
				g.endFill();
			}
			
		}
		
	}
}
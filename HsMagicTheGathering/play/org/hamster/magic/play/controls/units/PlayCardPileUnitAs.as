// ActionScript file
import flash.filters.GlowFilter;

import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;

import org.hamster.magic.common.models.Card;
import org.hamster.magic.common.services.AssetService;
			
private static var AS:AssetService = AssetService.getInstance();
private static const GLOW_FILTER:GlowFilter = new GlowFilter(0xFFFFFF, 0.5, 6, 6, 2, 3, true);

private var _playCardArray:ArrayCollection;
private var _isShowTopCard:Boolean;

private var _isSelected:Boolean;

public function set isSelected(value:Boolean):void
{
	this._isSelected = value;
	if (value) {
		this.filters = [GLOW_FILTER];
	} else {
		this.filters = [];
	}
}

public function get isSelected():Boolean
{
	return this._isSelected;
}

public function set playCardArray(value:ArrayCollection):void
{
	if (this._playCardArray != null) {
		this._playCardArray.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collChangeHandler);
	}
	this._playCardArray = value;
	this._playCardArray.addEventListener(CollectionEvent.COLLECTION_CHANGE, collChangeHandler);
	
	if (this.initialized) {
		showTopCard();
	}
}

public function get playCardArray():ArrayCollection
{
	return this._playCardArray;
}

public function set isShowTopCard(value:Boolean):void
{
	this._isShowTopCard = value;
}

public function get isShowTopCard():Boolean
{
	return this._isShowTopCard;
}

private function completeHandler():void
{
	showTopCard();
}

private function collChangeHandler(evt:CollectionEvent):void
{
	showTopCard();
}

private function showTopCard():void
{
	if (this.isShowTopCard == false 
			|| this.playCardArray == null 
			|| this.playCardArray.length == 0) {
		this.mainImage.source = AS.CARD_BACK;
	} else {
		this.mainImage.source = Card(this.playCardArray.getItemAt(0)).imgPath;
	}
}
// ActionScript file
import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;

import org.hamster.magic.common.models.Card;
import org.hamster.magic.common.services.AssetService;
			
private static var AS:AssetService = AssetService.getInstance();

private var _playCardArray:ArrayCollection;
private var _isShowTopCard:Boolean;

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
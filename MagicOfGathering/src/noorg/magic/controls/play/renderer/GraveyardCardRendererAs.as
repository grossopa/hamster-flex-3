// ActionScript file
import flash.events.MouseEvent;

import noorg.magic.controls.icons.IconReturnField;
import noorg.magic.controls.icons.IconReturnHand;
import noorg.magic.models.PlayCard;
import noorg.magic.models.staticValue.CardLocation;
import noorg.magic.utils.Constants;Constants;

protected var iconReturnHand:IconReturnHand;
protected var iconReturnField:IconReturnField;

override public function set data(value:Object):void
{
	this.card = PlayCard(value);
}

override public function get data():Object
{
	return this.card;
}

override protected function createIcon():void
{
	super.createIcon();
	
	this.iconTap.isEnabled = false;
	
	iconReturnHand = new IconReturnHand();
	iconReturnHand.visible = false;
	iconReturnHand.addEventListener(MouseEvent.CLICK, iconReturnHandClickHandler);
	this.addChild(iconReturnHand);
	
	iconReturnField = new IconReturnField();
	iconReturnField.addEventListener(MouseEvent.CLICK, iconReturnFieldClickHandler);
	// this.addChild(iconReturnField);
	
	this.iconManager.iconArrColl.addItem(iconReturnHand);
	//this.iconManager.iconArrColl.addItem(iconReturnField);
}

private function iconReturnHandClickHandler(evt:MouseEvent):void
{
	PlayCard(card).location = CardLocation.HAND;
}

private function iconReturnFieldClickHandler(evt:MouseEvent):void
{
	// PlayCard(card).location = CardLocation.;
}
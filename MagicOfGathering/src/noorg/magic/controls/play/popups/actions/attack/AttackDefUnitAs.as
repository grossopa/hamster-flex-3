// ActionScript file
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.events.DragEvent;
import mx.events.ListEvent;
import mx.managers.DragManager;

import noorg.magic.controls.play.renderer.DefCardRenderer;
import noorg.magic.events.PlayCardAttackEvent;
import noorg.magic.models.PlayCard;

private var _attackerCard:PlayCard;

[Bindable]
public var defCardList:ArrayCollection = new ArrayCollection();

[Bindable]
private var _attackImgSource:Object;

public function set attackerPlayCard(value:PlayCard):void
{
	this._attackerCard = value;
	_attackImgSource = value.imgPath;
}

public function get attackerPlayCard():PlayCard
{
	return this._attackerCard;
}

private function defDragEnterHandler(evt:DragEvent):void
{
	if (evt.dragInitiator is DefCardRenderer) {
		var renderer:DefCardRenderer = DefCardRenderer(evt.dragInitiator);
		
		for each (var playCard:PlayCard in this.defCardList) {
			if (playCard == renderer.playCard) {
				return;
			}
		}
		DragManager.acceptDragDrop(this.defenseCardList);
	}
}

private function defDragDropHandler(evt:DragEvent):void
{
	if (evt.dragInitiator is DefCardRenderer) {
		var renderer:DefCardRenderer = DefCardRenderer(evt.dragInitiator);
		this.defCardList.addItem(renderer.playCard);
	}	
}

private function attClickHandler(evt:MouseEvent):void
{
	var disEvt:PlayCardAttackEvent = new PlayCardAttackEvent(PlayCardAttackEvent.REMOVE_ATTACKER);
	disEvt.playCard = this.attackerPlayCard;
	this.dispatchEvent(disEvt);	
}

private function defItemClickHandler(evt:ListEvent):void
{
	this.defCardList.removeItemAt(this.defCardList.getItemIndex(evt.itemRenderer.data));
	
	var disEvt:PlayCardAttackEvent = new PlayCardAttackEvent(PlayCardAttackEvent.REMOVE_DEFENDER);
	disEvt.playCard = PlayCard(evt.itemRenderer.data);
	this.dispatchEvent(disEvt);
}
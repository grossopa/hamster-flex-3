// ActionScript file
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.events.DragEvent;
import mx.events.ListEvent;
import mx.managers.DragManager;

import noorg.magic.controls.play.renderer.AttCardRenderer;
import noorg.magic.controls.play.renderer.DefCardRenderer;
import noorg.magic.events.PlayCardAttackEvent;
import noorg.magic.models.PlayCard;
import noorg.magic.models.types.TypeCreature;

private var _attackerCard:PlayCard;

[Bindable]
public var defCardList:ArrayCollection = new ArrayCollection();

[Bindable]
private var _attackNum:int = 0;

[Bindable]
private var _attackImgSource:Object;

public function set attackerPlayCard(value:PlayCard):void
{
	this._attackerCard = value;
	_attackImgSource = value.imgPath;
	_attackNum = TypeCreature(value.type).attack;
	
}

public function get attackerPlayCard():PlayCard
{
	return this._attackerCard;
}

private function completeHandler():void
{
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
	
		var disEvt:PlayCardAttackEvent = new PlayCardAttackEvent(PlayCardAttackEvent.ADD_DEFENDER);
		disEvt.playCard = renderer.playCard;
		this.dispatchEvent(disEvt);		
	}
	
	validateResult();
}

private function attClickHandler(evt:MouseEvent):void
{
	var disEvt:PlayCardAttackEvent = new PlayCardAttackEvent(PlayCardAttackEvent.REMOVE_ATTACKER);
	disEvt.playCard = this.attackerPlayCard;
	disEvt.relatedCards = this.defCardList;
	this.dispatchEvent(disEvt);	
	
	validateResult();
}

private function defItemClickHandler(evt:ListEvent):void
{
	this.defCardList.removeItemAt(this.defCardList.getItemIndex(evt.itemRenderer.data));
	
	var disEvt:PlayCardAttackEvent = new PlayCardAttackEvent(PlayCardAttackEvent.REMOVE_DEFENDER);
	disEvt.playCard = PlayCard(evt.itemRenderer.data);
	this.dispatchEvent(disEvt);
	
	validateResult();
}

private function validateResult():void
{
	defenseCardList.validateNow();
	
	var attackerPower:int = TypeCreature(this.attackerPlayCard.type).attack;
	var attackerLife:int = TypeCreature(this.attackerPlayCard.type).defense;
	
	var isBlocked:Boolean = false;
	
	for each (var playCard:PlayCard in this.defCardList) {
		isBlocked = true;
		attackerPower -= TypeCreature(playCard.type).defense;
		attackerLife -= TypeCreature(playCard.type).attack;
		var renderer:AttCardRenderer = AttCardRenderer(this.defenseCardList.itemToItemRenderer(playCard));
		if (renderer != null) {
			if (attackerPower >= 0) {
				renderer.isKilled = true;
			} else {
				renderer.isKilled = false;
			}
		}
	}
	
	if (attackerLife <= 0) {
		attackerCardImage.alpha = 0.5;
	} else {
		attackerCardImage.alpha = 1;
	}
	
	_attackNum = isBlocked ? 0 : attackerPower;
}

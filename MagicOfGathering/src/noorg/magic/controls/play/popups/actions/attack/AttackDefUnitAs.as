// ActionScript file
import mx.collections.ArrayCollection;
import mx.events.DragEvent;
import mx.managers.DragManager;

import noorg.magic.controls.play.renderer.AttackDefCardRenderer;
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
	if (evt.dragInitiator is AttackDefCardRenderer) {
		var renderer:AttackDefCardRenderer = AttackDefCardRenderer(evt.dragInitiator);
		
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
	if (evt.dragInitiator is AttackDefCardRenderer) {
		var renderer:AttackDefCardRenderer = AttackDefCardRenderer(evt.dragInitiator);
		this.defCardList.addItem(renderer.playCard);
	}	
}
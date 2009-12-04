// ActionScript file

import flash.display.DisplayObject;

import mx.controls.Alert;

import noorg.magic.commands.impl.SaveDetailToFileCmd;
import noorg.magic.controls.unit.actions.ActionEditorBase;
import noorg.magic.controls.unit.actions.IActionEditor;
import noorg.magic.controls.unit.types.ITypeEditor;
import noorg.magic.models.Card;
import noorg.magic.models.actions.base.ICardAction;
import noorg.magic.models.staticValue.CardType;

import org.hamster.commands.events.CommandEvent;

private var _card:Card;

public function set card(value:Card):void
{
	this._card = value;
	if (this.initialized) {
		showCardProperties();
	}
}

public function get card():Card
{
	return this._card;
}

private function completeHandler():void
{
	showCardProperties();
}

private function cardTypeChangeHandler():void
{
	var index:int = this.cardTypeComboBox.selectedIndex;
	this.cardTypeViewStack.selectedIndex = index;
	if (this.card.type != null 
			&& CardType.typeMap.getKeyIndex(this.card.type.type) == index) {
		ITypeEditor(this.cardTypeViewStack.selectedChild).cardType = this.card.type;
		ITypeEditor(this.cardTypeViewStack.selectedChild).showTypeProperties();
	} else {
		ITypeEditor(this.cardTypeViewStack.selectedChild).initType();
	}
}

private function showCardProperties():void
{
	var childList:Array = this.getChildren();
	
	var selIndex:int;
	if (this.card.type != null) {
		selIndex = CardType.typeMap.getKeyIndex(this.card.type.type);
		this.cardTypeComboBox.selectedIndex = selIndex;
	} else {
		selIndex = 0;
		this.cardTypeComboBox.selectedIndex = selIndex;
	}
	
	this.magicCostEditorUnit.magicPool = this.card.magicPool;
	
	for each (var child:DisplayObject in childList) {
		if (child is IActionEditor) {
			this.removeChild(child);
		}
	}
	
	for each (var action:ICardAction in this.card.actionList) {
		this.addAction(action);
	}
}

public function addAction(action:ICardAction = null):void
{
	var obj:Object = actionTypeComboBox.selectedItem;
	var actionEditor:ActionEditorBase = new ActionEditorBase();
	actionEditor.action = action;
	this.addChild(actionEditor);	
}

private function addActionHandler():void
{
	var obj:Object = actionTypeComboBox.selectedItem;
	var actionEditor:ActionEditorBase = new ActionEditorBase();
	actionEditor.setActionClass(Class(obj.data));
	this.addChild(actionEditor);
}

private function saveToFileHandler():void
{
	this.card.removeAllActions();
	
	this.magicCostEditorUnit.validateMagicPool();
	this.card.type = ITypeEditor(this.cardTypeViewStack.selectedChild).getTypeClone();
	
	for each (var child:DisplayObject in this.getChildren()) {
		if (child is IActionEditor) {
			var editor:IActionEditor = IActionEditor(child);
			this.card.addAction(editor.getActionClone());
		}
	}
	
	var cmd:SaveDetailToFileCmd = new SaveDetailToFileCmd();
	cmd.card = this.card;
	cmd.addEventListener(CommandEvent.COMMAND_RESULT, saveFinishedHandler);
	cmd.execute();
}

private function saveFinishedHandler(evt:CommandEvent):void
{
	Alert.show("Success");
}
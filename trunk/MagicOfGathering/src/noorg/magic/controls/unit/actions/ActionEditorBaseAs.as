// ActionScript file
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.events.Event;

import mx.controls.CheckBox;

import noorg.magic.models.actions.base.ICardAction;
import noorg.magic.controls.unit.actions.items.ActionEditorComboBoxUnit;
import noorg.magic.controls.unit.actions.items.ActionEditorNumStepperUnit;
import noorg.magic.controls.unit.actions.items.IActionEditorItem;
import noorg.magic.events.CardEvent;
import noorg.magic.models.ActionAttribute;

[Bindable]
private var _action:ICardAction;

public function set action(value:ICardAction):void
{
	this._action = value;
}

public function setActionClass(value:Class):void
{
	_action = new value();
}

public function getActionClone():ICardAction
{
	var act:ICardAction = this._action.clone();
	
	var obj:Object = Object(act);
	
	for each (var child:DisplayObject in mainContainer.getChildren()) {
		if (child is IActionEditorItem) {
			var editorItem:IActionEditorItem = IActionEditorItem(child);
			obj[editorItem.actionAttribute.name] = editorItem.actionValue;
		}
	}
	
	return act;
}

private function completeHandler():void
{
	var i:int = 1;
	for each (var checkBox:CheckBox in this.targetCheckBoxList.getChildren()) {
		checkBox.selected = (this._action.affectTargets & i) != 0;
		i = i << 1;
	}
	
	// name ,type, listData
	for each (var actionAttribute:ActionAttribute in _action.editableAttributes) {
		this.addMoreAttributes(actionAttribute);
	}
}

private function addMoreAttributes(actionAttribute:ActionAttribute, limit:Object = null):void
{
	if (actionAttribute.type == ActionAttribute.TYPE_INT) {
		var numStepper:ActionEditorNumStepperUnit = new ActionEditorNumStepperUnit();
		numStepper.action = this._action;
		numStepper.actionAttribute = actionAttribute;
		mainContainer.addChild(numStepper);
	} else if (actionAttribute.type == ActionAttribute.TYPE_LIST) {
		var comboBox:ActionEditorComboBoxUnit = new ActionEditorComboBoxUnit();
		comboBox.action = this._action;
		comboBox.actionAttribute = actionAttribute;
		mainContainer.addChild(comboBox);
	} else if (actionAttribute.type == ActionAttribute.TYPE_STRING) {
		
	}
}

private function targetChangedHandler(evt:Event, value:int):void
{
	var checkBox:CheckBox = CheckBox(evt.currentTarget);
	
	if (checkBox.selected) {
		_action.affectTargets = _action.affectTargets | value;
	} else {
		_action.affectTargets = _action.affectTargets ^ value;
	}
}

private function deleteActionHandler():void
{
	this.parent.removeChild(this);
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	var g:Graphics = this.graphics;
	g.clear();
	g.lineStyle(1, 0x7F7F7F, 1);
	g.moveTo(0, 0);
	g.lineTo(0, uh);
	g.lineTo(uw, uh);
	g.lineTo(uw, 0);
	g.lineTo(0, 0);
	g.moveTo(0, 17);
	g.lineTo(uw, 17);
}

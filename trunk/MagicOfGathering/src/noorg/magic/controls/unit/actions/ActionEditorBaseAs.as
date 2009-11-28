// ActionScript file
import flash.display.Graphics;
import flash.events.Event;

import mx.controls.CheckBox;
import mx.events.ListEvent;

import noorg.magic.actions.base.ICardAction;
import noorg.magic.controls.unit.actions.items.ActionComboBox;
import noorg.magic.controls.unit.actions.items.ActionEditorNumStepperUnit;
import noorg.magic.models.ActionAttribute;
import noorg.magic.models.Card;

private var _card:Card;
private var _action:ICardAction;

public function set card(value:Card):void
{
	this._card = value;
}

public function get card():Card
{
	return this._card;
}
		
public function setActionClass(value:Class):void
{
	_action = new value();
}

public function get action():ICardAction
{
	return this._action.clone();
}

private function completeHandler():void
{
	// name ,type, listData
	for each (var actionAttribute:ActionAttribute in action.editableAttributes) {
		this.addMoreAttributes(actionAttribute);
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

public function addMoreAttributes(actionAttribute:ActionAttribute, limit:Object = null):void
{
	if (actionAttribute.type == ActionAttribute.TYPE_INT) {
		var numStepper:ActionEditorNumStepperUnit = new ActionEditorNumStepperUnit();
		numStepper.actionAttribute = actionAttribute;
		mainContainer.addChild(numStepper);
	} else if (actionAttribute.type == ActionAttribute.TYPE_LIST) {
		var comboBox:ActionComboBox = new ActionComboBox();
		comboBox.width = 80;
		comboBox.actionAttribute = actionAttribute;
		comboBox.dataProvider = actionAttribute.listData;
		comboBox.rowCount = actionAttribute.listData.length;
		comboBox.addEventListener(ListEvent.CHANGE, comboBoxChangedHandler);
		mainContainer.addChild(comboBox);
	} else if (actionAttribute.type == ActionAttribute.TYPE_STRING) {
		
	}
}

private function comboBoxChangedHandler(evt:ListEvent):void
{
	var comboBox:ActionComboBox = ActionComboBox(evt.currentTarget);
	var att:ActionAttribute = comboBox.actionAttribute;
	var obj:Object = Object(this.action);
	obj[att.name] = comboBox.actionValue;
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	var g:Graphics = this.graphics;
	g.lineStyle(1, 0x7F7F7F, 1);
	g.moveTo(0, 0);
	g.lineTo(0, uh);
	g.lineTo(uw, uh);
	g.lineTo(uw, 0);
	g.lineTo(0, 0);
}

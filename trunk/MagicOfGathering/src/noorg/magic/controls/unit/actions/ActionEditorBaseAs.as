// ActionScript file
import flash.events.Event;

import mx.controls.CheckBox;
import mx.controls.NumericStepper;
import mx.events.ListEvent;
import mx.events.NumericStepperEvent;

import noorg.magic.actions.base.ICardAction;
import noorg.magic.controls.unit.actions.items.ActionComboBox;
import noorg.magic.controls.unit.actions.items.ActionNumStepper;
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
		var numStepper:ActionNumStepper = new ActionNumStepper();
		numStepper.actionAttribute = actionAttribute;
		numStepper.width = 50;
		numStepper.stepSize = 1;
		numStepper.minimum = -20;
		numStepper.maximum = 20;
		numStepper.addEventListener(NumericStepperEvent.CHANGE, numStepperChangeHandler);
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

private function numStepperChangeHandler(evt:NumericStepperEvent):void
{
	var numStepper:ActionNumStepper = ActionNumStepper(evt.currentTarget);
	var att:ActionAttribute = numStepper.actionAttribute;
	var obj:Object = Object(this.action);
	obj[att.name] = numStepper.actionValue;
}


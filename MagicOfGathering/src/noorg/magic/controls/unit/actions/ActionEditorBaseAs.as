// ActionScript file
import flash.events.Event;

import mx.controls.CheckBox;
import mx.controls.ComboBox;
import mx.controls.NumericStepper;
import mx.events.ListEvent;
import mx.events.NumericStepperEvent;

import noorg.magic.actions.base.ICardAction;
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
		var numStepper:NumericStepper = new NumericStepper();
		numStepper.data = actionAttribute;
		numStepper.width = 40;
		numStepper.stepSize = 1;
		numStepper.addEventListener(NumericStepperEvent.CHANGE, numStepperChangeHandler);
		this.addChild(numStepper);
	} else if (actionAttribute.type == ActionAttribute.TYPE_LIST) {
		var comboBox:ComboBox = new ComboBox();
		comboBox.width = 60;
		comboBox.data = actionAttribute;
		comboBox.dataProvider = actionAttribute.listData;
		comboBox.addEventListener(ListEvent.CHANGE, comboBoxChangedHandler);
		this.addChild(comboBox);
	} else if (actionAttribute.type == ActionAttribute.TYPE_STRING) {
		
	}
	
	
}

private function comboBoxChangedHandler(evt:ListEvent):void
{
	var comboBox:ComboBox = ComboBox(evt.currentTarget);
	var att:ActionAttribute = comboBox.data as ActionAttribute;
	var obj:Object = Object(this.action);
	obj[att.name] = comboBox.value;
}

private function numStepperChangeHandler(evt:NumericStepperEvent):void
{
	var numStepper:NumericStepper = NumericStepper(evt.currentTarget);
	var att:ActionAttribute = numStepper.data as ActionAttribute;
	var obj:Object = Object(this.action);
	obj[att.name] = numStepper.value;
}


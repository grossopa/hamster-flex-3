// ActionScript file
import flash.events.Event;

import mx.controls.CheckBox;

import org.hamster.magic.common.models.action.utils.SimpleActionFactory;
import org.hamster.magic.common.models.action.utils.SimpleActionInfo;

private var _selectedSimpleActions:Array;

public function get selectedSimpleActions():Array
{
	return _selectedSimpleActions;
}

private function completeHandler():void
{
	var supportActions:Array = SimpleActionFactory.supportActions;
	for each (var info:SimpleActionInfo in supportActions) {
		var checkBox:CheckBox = new CheckBox();
		checkBox.label = info.name;
		checkBox.width = mainCheckBoxContainer.width / 4;
		checkBox.height = 20;
		checkBox.x = (mainCheckBoxContainer.numChildren % 4) * 100;
		checkBox.y = Math.floor(this.numChildren / 4) * 20;
		this.mainCheckBoxContainer.addChild(checkBox);
	}
}

private function saveAndCloseHandler():void
{
	_selectedSimpleActions = new Array();
	for each (var checkBox:CheckBox in this.mainCheckBoxContainer.getChildren()) {
		if (checkBox.selected) {
			for each (var info:SimpleActionInfo in SimpleActionFactory.supportActions) {
				if (info.name == checkBox.label) {
					_selectedSimpleActions.push(info);
					break;
				}
			}
		}
	}
	this.dispatchEvent(new Event(Event.CLOSE));
}

private function closeHandler():void
{
	_selectedSimpleActions = new Array();
	this.dispatchEvent(new Event(Event.CANCEL));
}
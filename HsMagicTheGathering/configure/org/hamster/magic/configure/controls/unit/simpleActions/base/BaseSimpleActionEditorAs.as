// ActionScript file
import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;

[Bindable]
protected var _name:String;

private var _simpleAction:ISimpleAction;

public function get selected():Boolean
{
	return this.checkBox.selected;
}

public function set simpleAction(value:ISimpleAction):void
{
	this._simpleAction = value;
	if (this.initialized) {
		initProperties();
	}
}

public function get simpleAction():ISimpleAction
{
	return this._simpleAction;
}

protected function completeHandler():void
{
	if (this.simpleAction != null) {
		this.initProperties();
	}
}

protected function initProperties():void
{
	
}

public function applyChanges():ISimpleAction
{
	return null;
}
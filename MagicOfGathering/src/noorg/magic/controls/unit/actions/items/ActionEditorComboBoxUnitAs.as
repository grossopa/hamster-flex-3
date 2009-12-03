// ActionScript file
import flash.display.Graphics;

import noorg.magic.models.actions.base.ICardAction;
import noorg.magic.models.ActionAttribute;

[Bindable]
private var _actionAttribute:ActionAttribute;

private var _ownAction:ICardAction;
public function set action(value:ICardAction):void
{
	this._ownAction = value;
}

public function get action():ICardAction
{
	return this._ownAction;
}
		
public function set actionAttribute(value:ActionAttribute):void
{
	this._actionAttribute = value;
	if (this.initialized) {
		this.comboBox.dataProvider = value.listData;
		this.comboBox.rowCount = value.listData.length;
	}
}
		
public function get actionAttribute():ActionAttribute
{
	return this._actionAttribute;
	
}
		
public function get actionValue():Object
{
	return this.comboBox.selectedItem;
}

private function completeHandler():void
{
	this.comboBox.dataProvider = actionAttribute.listData;
	this.comboBox.rowCount = actionAttribute.listData.length;
	this.comboBox.selectedItem = Object(this.action)[this.actionAttribute.name];
	
	trace ( Object(this.action)[this.actionAttribute.name]);
}


override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	var g:Graphics = this.graphics;
	g.lineStyle(1, 0x7F7F7F);
	g.moveTo(5, 20);
	g.lineTo(uw - 5, 20);
	
	g.moveTo(0, 0);
	g.lineTo(0, uh);
}
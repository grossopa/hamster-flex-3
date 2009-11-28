// ActionScript file
import flash.display.Graphics;

import noorg.magic.models.ActionAttribute;

[Bindable]
private var _actionAttribute:ActionAttribute;
		
public function set actionAttribute(value:ActionAttribute):void
{
	this._actionAttribute = value;
}
		
public function get actionAttribute():ActionAttribute
{
	return this._actionAttribute;
}
		
public function get actionValue():Object
{
	return this.numStepper.value;
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	var g:Graphics = this.graphics;
	g.lineStyle(1, 0x7F7F7F);
	g.moveTo(5, 20);
	g.lineTo(uw - 5, 20);
}
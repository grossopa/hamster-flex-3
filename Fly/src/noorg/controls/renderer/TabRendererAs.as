// ActionScript file
import noorg.controls.renderer.TabRenderer;

[Bindable]
private var _labelColor:Number = 0x777777;
[Bindable]
private var _bgColor:Number = 0x444444;

[Bindable]
private var _labelText:String;

private function completeHandler():void
{
	
}

override public function set label(value:String):void
{
	super.label = value;
	_labelText = value;
}

override public function set selected(value:Boolean):void
{
	super.selected = value;
	
	if (value) {
		_labelColor = 0xFFFFFF;
		_bgColor = 0xAAAAAA;
	} else {
		_labelColor = 0x777777;
		_bgColor = 0x444444;
	}
}

public function newInstance():*
{
	return new TabRenderer();
}
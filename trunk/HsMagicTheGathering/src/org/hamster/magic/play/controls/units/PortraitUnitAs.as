// ActionScript file
private var _source:Object;

public function set source(value:Object):void
{
	this._source = value;
}

[Bindable]
public function get source():Object
{
	return this._source;
}
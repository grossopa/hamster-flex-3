// ActionScript file
import noorg.magic.models.types.TypeInstant;
import noorg.magic.models.types.base.ICardType;

private var _typeInstant:TypeInstant;

public function set cardType(value:ICardType):void
{
	this._typeInstant = TypeInstant(value);
}

public function get cardType():ICardType
{
	return this._typeInstant;
}

public function initType():void
{
	this._typeInstant = new TypeInstant();
}

public function showTypeProperties():void
{
}

public function validateTypeProperties():void
{
}

public function getTypeClone():ICardType
{
	return null;
}
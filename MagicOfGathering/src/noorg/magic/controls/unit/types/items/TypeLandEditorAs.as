// ActionScript file
import noorg.magic.models.types.TypeLand;
import noorg.magic.models.types.base.ICardType;

private var _typeLand:TypeLand;

public function set cardType(value:ICardType):void
{
	this._typeLand = TypeLand(value);
}

public function get cardType():ICardType
{
	return this._typeLand;
}

public function initType():void
{
	this._typeLand = new TypeLand();
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
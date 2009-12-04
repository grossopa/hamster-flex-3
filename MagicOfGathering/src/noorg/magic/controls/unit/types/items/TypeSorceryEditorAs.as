// ActionScript file
import noorg.magic.models.types.TypeSorcery;
import noorg.magic.models.types.base.ICardType;

private var _typeSorcery:TypeSorcery;

public function set cardType(value:ICardType):void
{
	this._typeSorcery = TypeSorcery(value);
}

public function get cardType():ICardType
{
	return this._typeSorcery;
}

public function initType():void
{
	this._typeSorcery = new TypeSorcery();
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
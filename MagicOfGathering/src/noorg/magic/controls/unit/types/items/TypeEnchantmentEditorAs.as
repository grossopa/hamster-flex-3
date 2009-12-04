// ActionScript file
import noorg.magic.models.types.TypeEnchantment;
import noorg.magic.models.types.base.ICardType;

private var _typeEnchantment:TypeEnchantment;

public function set cardType(value:ICardType):void
{
	this._typeEnchantment = TypeEnchantment(value);
}

public function get cardType():ICardType
{
	return this._typeEnchantment;
}

public function initType():void
{
	this._typeEnchantment = new TypeEnchantment();
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
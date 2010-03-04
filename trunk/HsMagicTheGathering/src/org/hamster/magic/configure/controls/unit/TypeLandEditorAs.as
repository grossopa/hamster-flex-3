// ActionScript file
import org.hamster.magic.common.models.type.TypeLand;
import org.hamster.magic.common.models.type.base.ICardType;

private var _typeLand:TypeLand;

public function get typeLand():TypeLand
{
	return this._typeLand;
}

private function completeHandler():void
{
	if (this.typeLand == null) {
		this.initType();	
	}
	this.validateTypeProperties();
}

public function set cardType(value:ICardType):void
{
	if (value != null) {
		this._typeLand = TypeLand(value);
	} else {
		this.initType();
	}
	if (this.initialized) {
		this.validateTypeProperties();
	}
}

public function get cardType():ICardType
{
	return this._typeLand;
}

public function initType():void
{
	this._typeLand = new TypeLand();
}

public function getTypeClone():ICardType
{
	return this.cardType.clone();
}

public function showTypeProperties():void
{
}

public function validateTypeProperties():void
{
}


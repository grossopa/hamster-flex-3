// ActionScript file
import org.hamster.magic.common.models.type.TypeInstant;
import org.hamster.magic.common.models.type.base.ICardType;

private var _typeInstant:TypeInstant;

public function get typeInstant():TypeInstant
{
	return this._typeInstant;
}

private function completeHandler():void
{
	if (this.typeInstant == null) {
		this.initType();	
	}
	this.validateTypeProperties();
}

public function set cardType(value:ICardType):void
{
	if (value != null) {
		this._typeInstant = TypeInstant(value);
	} else {
		this.initType();
	}
	if (this.initialized) {
		this.validateTypeProperties();
	}
}

public function get cardType():ICardType
{
	return this._typeInstant;
}

public function initType():void
{
	this._typeInstant = new TypeInstant();
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


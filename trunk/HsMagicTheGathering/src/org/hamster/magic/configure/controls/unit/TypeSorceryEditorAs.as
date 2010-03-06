// ActionScript file
import org.hamster.magic.common.models.type.TypeSorcery;
import org.hamster.magic.common.models.type.base.ICardType;

private var _typeSorcery:TypeSorcery;

public function get typeSorcery():TypeSorcery
{
	return this._typeSorcery;
}

private function completeHandler():void
{
	if (this.typeSorcery == null) {
		this.initType();	
	}
	this.showTypeProperties();
}

public function set cardType(value:ICardType):void
{
	if (value != null) {
		this._typeSorcery = TypeSorcery(value);
	} else {
		this.initType();
	}
	if (this.initialized) {
		this.showTypeProperties();
	}
}

public function get cardType():ICardType
{
	return this._typeSorcery;
}

public function initType():void
{
	this._typeSorcery = new TypeSorcery();
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


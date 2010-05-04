// ActionScript file
import org.hamster.magic.common.models.type.TypeEnchantment;
import org.hamster.magic.common.models.type.base.ICardType;

private var _typeEnchantment:TypeEnchantment;

public function get typeEnchantment():TypeEnchantment
{
	return this._typeEnchantment;
}

private function completeHandler():void
{
	if (this.typeEnchantment == null) {
		this.initType();	
	}
	this.showTypeProperties();
}

public function set cardType(value:ICardType):void
{
	if (value != null) {
		this._typeEnchantment = TypeEnchantment(value);
	} else {
		this.initType();
	}
	if (this.initialized) {
		this.showTypeProperties();
	}
}

public function get cardType():ICardType
{
	return this._typeEnchantment;
}

public function initType():void
{
	this._typeEnchantment = new TypeEnchantment();
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
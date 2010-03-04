// ActionScript file
import org.hamster.magic.common.models.type.TypeArtifact;
import org.hamster.magic.common.models.type.base.ICardType;

private var _typeArtifact:TypeArtifact;

public function get typeArtifact():TypeArtifact
{
	return this._typeArtifact;
}

private function completeHandler():void
{
	if (this.typeArtifact == null) {
		this.initType();	
	}
	this.validateTypeProperties();
}

public function set cardType(value:ICardType):void
{
	if (value != null) {
		this._typeArtifact = TypeArtifact(value);
	} else {
		this.initType();
	}
	if (this.initialized) {
		this.validateTypeProperties();
	}
}

public function get cardType():ICardType
{
	return this._typeArtifact;
}

public function initType():void
{
	this._typeArtifact = new TypeArtifact();
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

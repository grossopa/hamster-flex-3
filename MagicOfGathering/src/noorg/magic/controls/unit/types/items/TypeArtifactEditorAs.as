// ActionScript file
import noorg.magic.models.types.TypeArtifact;
import noorg.magic.models.types.base.ICardType;

private var _typeArtifact:TypeArtifact;

public function set cardType(value:ICardType):void
{
	this._typeArtifact = TypeArtifact(value);
}

public function get cardType():ICardType
{
	return this._typeArtifact;
}

public function initType():void
{
	this._typeArtifact = new TypeArtifact();
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
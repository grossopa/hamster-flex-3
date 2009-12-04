// ActionScript file
import noorg.magic.models.Card;
import noorg.magic.models.types.TypeCreature;
import noorg.magic.models.types.base.ICardType;

private var _typeCreature:TypeCreature = new TypeCreature();

public function set cardType(value:ICardType):void
{
	this._typeCreature = TypeCreature(value);
}

public function get cardType():ICardType
{
	return this._typeCreature;
}

private function completeHandler():void
{
	this.showTypeProperties();
}

public function initType():void
{
	this._typeCreature = new TypeCreature();
}

public function showTypeProperties():void
{
	this.attackNumStepper.value = this._typeCreature.attack;
	this.defenseNumStepper.value = this._typeCreature.defense;
	this.flyingCheckBox.selected = this._typeCreature.isFlying;
	this.reachCheckBox.selected = this._typeCreature.isReach;
	this.firstStrikeCheckBox.selected = this._typeCreature.isFirstStrike;
}

public function validateTypeProperties():void
{
	this._typeCreature.attack = this.attackNumStepper.value;
	this._typeCreature.defense = this.defenseNumStepper.value;
	this._typeCreature.isFlying = this.flyingCheckBox.selected;
	this._typeCreature.isReach = this.reachCheckBox.selected;
	this._typeCreature.isFirstStrike = this.firstStrikeCheckBox.selected;
}

public function getTypeClone():ICardType
{
	validateTypeProperties();
	return this._typeCreature.clone();
}
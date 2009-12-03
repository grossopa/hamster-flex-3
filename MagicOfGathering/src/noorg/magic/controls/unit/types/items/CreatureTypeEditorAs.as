// ActionScript file
import noorg.magic.models.Card;
import noorg.magic.models.types.TypeCreature;
import noorg.magic.models.types.base.ICardType;

public var card:Card;
public var typeCreature:TypeCreature = new TypeCreature();

private function completeHandler():void
{
	this.showTypeProperties();
}

public function initType():void
{
	this.typeCreature = new TypeCreature();
}

public function showTypeProperties():void
{
	this.attackNumStepper.value = this.typeCreature.attack;
	this.defenseNumStepper.value = this.typeCreature.defense;
	this.flyingCheckBox.selected = this.typeCreature.isFlying;
	this.reachCheckBox.selected = this.typeCreature.isReach;
	this.firstStrikeCheckBox.selected = this.typeCreature.isFirstStrike;
}

public function validateTypeProperties():void
{
	this.typeCreature.attack = this.attackNumStepper.value;
	this.typeCreature.defense = this.defenseNumStepper.value;
	this.typeCreature.isFlying = this.flyingCheckBox.selected;
	this.typeCreature.isReach = this.reachCheckBox.selected;
	this.typeCreature.isFirstStrike = this.firstStrikeCheckBox.selected;
}

public function getTypeClone():ICardType
{
	validateTypeProperties();
	return this.typeCreature.clone();
}
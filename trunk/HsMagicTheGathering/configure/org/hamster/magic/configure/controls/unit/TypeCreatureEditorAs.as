// ActionScript file
import org.hamster.magic.common.models.type.TypeCreature;
import org.hamster.magic.common.models.type.base.ICardType;

private var _typeCreature:TypeCreature;

public function get typeCreature():TypeCreature
{
	return this._typeCreature;
}

private function completeHandler():void
{
	if (this.typeCreature == null) {
		this.initType();	
	}
	this.showTypeProperties();
}

public function set cardType(value:ICardType):void
{
	if (value != null) {
		this._typeCreature = TypeCreature(value);
	} else {
		this.initType();
	}
	if (this.initialized) {
		this.showTypeProperties();
	}
}

public function get cardType():ICardType
{
	return this._typeCreature;
}

public function initType():void
{
	this._typeCreature = new TypeCreature();
}

public function getTypeClone():ICardType
{
	return this.cardType.clone();
}

public function showTypeProperties():void
{
	this.attackStepper.value = this.typeCreature.attack;
	this.defenceStepper.value = this.typeCreature.defense;
	this.isDoubleStrikeCheckBox.selected = this.typeCreature.isDoubleStrike;
	this.isFirstStrikeCheckBox.selected = this.typeCreature.isFirstStrike;
	this.isFlyingCheckBox.selected = this.typeCreature.isFlying;
	this.isHasteCheckBox.selected = this.typeCreature.isHaste;
	// this.typeCreature.isLandwalk;
	this.isReachCheckBox.selected = this.typeCreature.isReach;
	this.isTrampleCheckBox.selected = this.typeCreature.isTrample;
	this.isVigilanceCheckBox.selected = this.typeCreature.isVigilance;
}

public function validateTypeProperties():void
{
	this.typeCreature.attack = this.attackStepper.value;
	this.typeCreature.defense = this.defenceStepper.value;
	this.typeCreature.isDoubleStrike = this.isDoubleStrikeCheckBox.selected;
	this.typeCreature.isFirstStrike = this.isFirstStrikeCheckBox.selected;
	this.typeCreature.isFlying = this.isFlyingCheckBox.selected;
	this.typeCreature.isHaste = this.isHasteCheckBox.selected;
//	this.typeCreature.isLandwalk = ;
	this.typeCreature.isReach = this.isReachCheckBox.selected;
	this.typeCreature.isTrample = this.isTrampleCheckBox.selected;
	this.typeCreature.isVigilance = this.isVigilanceCheckBox.selected;	
}

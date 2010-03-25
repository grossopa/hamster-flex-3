// ActionScript file
import org.hamster.magic.common.models.action.CardAction;
import org.hamster.magic.common.models.utils.GameStep;


private var _cardAction:CardAction;

public function set cardAction(value:CardAction):void
{
	this._cardAction = value;
	if (this.initialized) {
		initializeActionProperties();
	}
}

public function get cardAction():CardAction
{
	return this._cardAction;	
}

private function addSimpleActionHandler():void
{
	
}

private function removeSimpleActionHandler():void
{
	
}

private function actionEditorContainerCompleteHandler():void
{
	if (this.cardAction != null) {
		initializeActionProperties();
	}
}

public function applyChanges():CardAction
{
	return null;
}

private function initializeActionProperties():void
{
	this.stepBeginningCheckBox.selected = false;
	this.stepMainCheckBox.selected = false;
	this.stepCombatCheckBox.selected = false;
	this.stepEndingCheckBox.selected = false;
	
	for each (var step:int in this.cardAction.steps) {
		if (step == GameStep.P_1_BEGINNING) {
			this.stepBeginningCheckBox.selected = true;
		} else if (step == GameStep.P_2_MAIN) {
			this.stepMainCheckBox.selected = true;
		} else if (step == GameStep.P_3_COMBAT) {
			this.stepCombatCheckBox.selected = true;
		} else if (step == GameStep.P_4_ENDING) {
			this.stepEndingCheckBox.selected = true;
		}
	}
	
//	GameStep.S_11_UNTAP;
//	GameStep.S_12_UPKEEP;
//	GameStep.S_13_DRAW;
//	GameStep.S_31_BEGINNING_OF_COMBAT;
//	GameStep.S_32_DECLARE_ATTACKERS;
//	GameStep.S_33_DECLARE_BLOCKERS;
//	GameStep.S_34_COMBAT_DAMAGE;
//	GameStep.S_35_END_OF_COMBAT;
//	GameStep.S_41_END;
//	GameStep.S_42_CLEANUP;
		
	//this.simpleActionEditorContainer.removeAllChildren();
	
	
}
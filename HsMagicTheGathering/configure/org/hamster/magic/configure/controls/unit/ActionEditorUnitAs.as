// ActionScript file
import flash.events.Event;

import mx.core.Application;
import mx.core.IFlexDisplayObject;
import mx.core.UIComponent;
import mx.managers.PopUpManager;

import org.hamster.magic.common.models.action.CardAction;
import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
import org.hamster.magic.common.models.action.utils.ActionTarget;
import org.hamster.magic.common.models.action.utils.SimpleActionFactory;
import org.hamster.magic.common.models.action.utils.SimpleActionInfo;
import org.hamster.magic.common.models.utils.GameStep;
import org.hamster.magic.configure.controls.popups.SimpleActionSelectionPopup;
import org.hamster.magic.configure.controls.unit.simpleActions.base.BaseSimpleActionEditor;

private var _cardAction:CardAction = new CardAction();

public function get selected():Boolean
{
	return selectCheckBox == null ? false : selectCheckBox.selected;
}

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
	var obj:IFlexDisplayObject = 
			PopUpManager.createPopUp(Application.application as UIComponent, 
			SimpleActionSelectionPopup, true);
	obj.addEventListener(Event.CLOSE, function (evt:Event):void
	{
		var popup:SimpleActionSelectionPopup = SimpleActionSelectionPopup(evt.currentTarget);
		for each (var info:SimpleActionInfo in popup.selectedSimpleActions) {
			simpleActionEditorContainer.addChild(new info.editorType());
		}
		PopUpManager.removePopUp(evt.currentTarget as UIComponent);
	});
	obj.addEventListener(Event.CANCEL, function (evt:Event):void
	{
		PopUpManager.removePopUp(evt.currentTarget as UIComponent);
	});
	PopUpManager.centerPopUp(obj);
}

private function removeSimpleActionHandler():void
{
	var removeArray:Array = [];
	for each (var simpleActionEditor:BaseSimpleActionEditor 
			in this.simpleActionEditorContainer.getChildren()) {
		if (simpleActionEditor.selected) {
			removeArray.push(simpleActionEditor);
		}		
	}
	for each (var e:BaseSimpleActionEditor in removeArray) {
		this.simpleActionEditorContainer.removeChild(e);			
	}
}

private function actionEditorContainerCompleteHandler():void
{
	if (this.cardAction != null) {
		initializeActionProperties();
	}
}

public function applyChanges():CardAction
{
	if (this.cardAction == null) {
		this.cardAction = new CardAction();
	}
	
	if (this.nameTextInput.text == "") {
		this.nameTextInput.text = "新动作";
	}
	this.cardAction.name = this.nameTextInput.text;
	this.cardAction.notNeedTap = this.notNeedTapCheckBox.selected;
	
	this.cardAction.cost = this.costMagicUnit.applyChanges();
	
	var steps:Array = new Array();
	if (this.stepBeginningCheckBox.selected) {
		 steps.push(GameStep.P_1_BEGINNING);
	}
	if (this.stepMainCheckBox.selected) {
		steps.push(GameStep.P_2_MAIN);
	}
	if (this.stepCombatCheckBox.selected) {
		steps.push(GameStep.P_3_COMBAT);
	}
	if (this.stepEndingCheckBox.selected) {
		steps.push(GameStep.P_4_ENDING);
	}
	this.cardAction.steps = steps;
	
	var targets:Array = new Array();
	if (this.targetSelfPlayerCheckBox.selected) {
		targets.push(ActionTarget.PLAYER);
	}
	if (this.targetSelfCreaturesCheckBox.selected) {
		targets.push(ActionTarget.CREATURE);
	}
	this.cardAction.targets = targets;
	
	var simpleActions:Array = new Array();
	for each (var simpleActionEditor:BaseSimpleActionEditor 
			in simpleActionEditorContainer.getChildren()) {
		simpleActions.push(simpleActionEditor.applyChanges());	
	}
	this.cardAction.simpleActions = simpleActions;
	
	return this.cardAction;
}

private function initializeActionProperties():void
{
	this.nameTextInput.text = this.cardAction.name;
	this.notNeedTapCheckBox.selected = this.cardAction.notNeedTap;
	
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
	
	costMagicUnit.magic = this.cardAction.cost.clone();
	
	this.targetSelfPlayerCheckBox.selected = false;
	this.targetSelfCreaturesCheckBox.selected = false;
	this.targetOppositePlayerCheckBox.selected = false;
	this.targetOppositeCreaturesCheckBox.selected = false;
	
	for each (var target:int in this.cardAction.targets) {
		if (target == ActionTarget.PLAYER) {
			this.targetSelfPlayerCheckBox.selected = true;
		} else if (target == ActionTarget.CREATURE) {
			this.targetSelfCreaturesCheckBox.selected = true;
		}
	}
	
	this.simpleActionEditorContainer.removeAllChildren();
	for each (var simpleAction:ISimpleAction in this.cardAction.simpleActions) {
		var editor:BaseSimpleActionEditor = SimpleActionFactory.createEditor(simpleAction.type);
		editor.simpleAction = simpleAction;
		this.simpleActionEditorContainer.addChild(editor);
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
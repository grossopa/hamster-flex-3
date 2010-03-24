// ActionScript file
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.ListEvent;

import org.hamster.commands.events.CommandEvent;
import org.hamster.magic.common.commands.LoadUserCollCmd;
import org.hamster.magic.common.commands.SaveDetailToFileCmd;
import org.hamster.magic.common.commands.SaveUserCardCollCmd;
import org.hamster.magic.common.models.Card;
import org.hamster.magic.common.models.CardCollection;
import org.hamster.magic.common.models.Magic;
import org.hamster.magic.common.models.action.CardAction;
import org.hamster.magic.common.models.type.TypeArtifact;
import org.hamster.magic.common.models.type.TypeCreature;
import org.hamster.magic.common.models.type.TypeEnchantment;
import org.hamster.magic.common.models.type.TypeInstant;
import org.hamster.magic.common.models.type.TypeLand;
import org.hamster.magic.common.models.type.TypeSorcery;
import org.hamster.magic.common.models.type.utils.CardType;
import org.hamster.magic.common.services.DataService;
import org.hamster.magic.configure.controls.unit.ActionEditorUnit;
import org.hamster.magic.configure.controls.unit.base.ITypeEditor;
import org.hamster.magic.play.controls.items.MagicCircleItem;

private static const DS:DataService = DataService.getInstance();
private static const TYPE_ARRAY:Array = [
	{"name":"生物","value":CardType.CREATURE},
	{"name":"神器","value":CardType.ARTIFACT},
	{"name":"增强法术（持久）","value":CardType.ENCHANTMENT},
	{"name":"瞬间","value":CardType.INSTANT},
	{"name":"法术","value":CardType.SORCERY},
	{"name":"地","value":CardType.LAND}
];

[Bindable]
public var cardCollectionNames:Array;

[Bindable]
public var userCollectionNames:Array;

[Bindable]
public var cards:ArrayCollection;

[Bindable]
public var selectedCards:ArrayCollection;

private var _currentCard:Card;

public function set currentCard(value:Card):void
{
	this._currentCard = value;
	this.saveCardButton.enabled = this._currentCard != null;
}

public function get currentCard():Card
{
	return this._currentCard;
}

private function completeHandler():void
{
	cardTypeComboBox.dataProvider = TYPE_ARRAY;
	cardCollectionNames = new Array();
	userCollectionNames = new Array();
	
	for each (var cardColl:CardCollection in DS.cardCollections) {
		cardCollectionNames.push(cardColl.name);
	}
	
	for each (var name:String in DS.userCollNames) {
		userCollectionNames.push(name);
	}
}

private function magicUnitCompleteHandler():void
{
	for each (var child:MagicCircleItem in this.magicUnit.getChildren()) {
		child.addEventListener(MouseEvent.CLICK, magicUnitItemClickHandler);
		child.addEventListener(MouseEvent.RIGHT_CLICK, magicUnitRightClickHandler);
	}
	
	this.magicUnit.magic = new Magic();
}

private function magicUnitItemClickHandler(evt:MouseEvent):void
{
	var item:MagicCircleItem = MagicCircleItem(evt.currentTarget);
	item.magicValue += 1;
	if (item.magicValue >= 20) {
		item.magicValue = 20;
	}
}

private function magicUnitRightClickHandler(evt:MouseEvent):void
{
	var item:MagicCircleItem = MagicCircleItem(evt.currentTarget);
	item.magicValue -= 1;
	if (item.magicValue <= 0) {
		item.magicValue = 0;
	}	
}

private function cardCollectionChangeHandler():void
{
	for each (var cardCollection:CardCollection in DS.cardCollections) {
		if (cardCollection.name == String(this.cardCollectionNameComboBox.selectedItem)) {
			this.cards = cardCollection.cards;
		}
	}
}

private function userCollectionChangeHandler():void
{
	if (this.userCollectionComboBox.selectedIndex == -1) {
		return;
	}
	this.userCollectionNameInput.text = String(this.userCollectionComboBox.selectedItem);
	var cmd:LoadUserCollCmd = new LoadUserCollCmd();
	cmd.name = this.userCollectionNameInput.text;
	cmd.addEventListener(CommandEvent.COMMAND_RESULT, loadUserCollectionResultHandler);
	cmd.execute();
}

private function loadUserCollectionResultHandler(evt:CommandEvent):void
{
	this.selectedCards = LoadUserCollCmd(evt.currentTarget).cards;
}

private function inputUserCollNameChangeHandler():void
{
	if (this.userCollectionNames.indexOf(this.userCollectionNameInput.text) > 0) {
		// this.userCollectionComboBox.selectedItem = this.userCollectionNameInput.text;
	} else {
		this.userCollectionComboBox.selectedIndex = -1;
	}
}

private function selectCardChangeHandler():void
{
	currentCard = this.cardHList.selectedItem as Card;
	cardViewUnit.card = currentCard;
	
	if (currentCard.type == null) {
		this.baseTypeViewStack.selectedIndex = 0;
	} else {
		if (currentCard.type is TypeCreature) {
			this.baseTypeViewStack.selectedIndex = 0;
		} else if (currentCard.type is TypeArtifact) {
			this.baseTypeViewStack.selectedIndex = 1;
		} else if (currentCard.type is TypeEnchantment) {
			this.baseTypeViewStack.selectedIndex = 2;
		} else if (currentCard.type is TypeInstant) {
			this.baseTypeViewStack.selectedIndex = 3;
		} else if (currentCard.type is TypeSorcery) {
			this.baseTypeViewStack.selectedIndex = 4;
		} else if (currentCard.type is TypeLand) {
			this.baseTypeViewStack.selectedIndex = 5;
		}
	}
	
	this.magicUnit.magic.decodeString(currentCard.magic.encodeString());
	
	ITypeEditor(this.baseTypeViewStack.selectedChild).cardType = this.currentCard.type;
	this.actionEditorContainer.removeAllChildren();
	
	for each (var action:CardAction in this.currentCard.actions) {
		var temp:ActionEditorUnit = new ActionEditorUnit();
		temp.cardAction = action.clone();
		this.actionEditorContainer.addChild(temp);
	}
}

private function cardTypeChangeHandler():void
{
	this.baseTypeViewStack.selectedIndex = this.cardTypeComboBox.selectedIndex;
}

private function saveCard():void
{
	if (this.currentCard != null) {
		ITypeEditor(this.baseTypeViewStack.selectedChild).validateTypeProperties();
		this.currentCard.magic.decodeString(this.magicUnit.magic.encodeString());
		this.currentCard.type = ITypeEditor(this.baseTypeViewStack.selectedChild).cardType.clone();
		var actions:Array = new Array();
		for each (var actionUnit:ActionEditorUnit in this.actionEditorContainer.getChildren()) {
			actions.push(actionUnit.applyChanges());
		}
		this.currentCard.actions = actions;
		var cmd:SaveDetailToFileCmd = new SaveDetailToFileCmd();
		cmd.card = this.currentCard;
		cmd.addEventListener(CommandEvent.COMMAND_RESULT, saveCompleteHandler);
		cmd.execute();
	}
}

private function cardCollDoubleClickHandler(evt:ListEvent):void {
	var card:Card = Card(this.cardHList.selectedItem);
	if (this.selectedCards.contains(card)) {
		card.isSelected = false;
		card.count = 0;
		this.selectedCards.removeItemAt(
				this.selectedCards.getItemIndex(card));
	} else {
		this.selectedCards.addItem(card);
		card.isSelected = true;
	}
}

private function saveCollectionHandler():void
{
	if (this.userCollectionNameInput.text == "") {
		return;
	}
	var cmd:SaveUserCardCollCmd = new SaveUserCardCollCmd();
	cmd.cards = this.selectedCards;
	cmd.name = this.userCollectionNameInput.text;
	cmd.addEventListener(CommandEvent.COMMAND_RESULT, saveCompleteHandler);
	cmd.execute();
}

private function saveCompleteHandler(evt:CommandEvent):void
{
	Alert.show("保存成功！");
}

private function addCardActionHandler():void
{
	var newActionEditor:ActionEditorUnit = new ActionEditorUnit();
	this.actionEditorContainer.addChild(newActionEditor);
}
// ActionScript file
import mx.collections.ArrayCollection;

import org.hamster.magic.common.models.Card;
import org.hamster.magic.common.models.CardCollection;
import org.hamster.magic.common.models.type.utils.CardType;
import org.hamster.magic.common.services.DataService;
import org.hamster.magic.configure.controls.unit.base.ITypeEditor;

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

private var _currentCard:Card;

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
}

private function inputUserCollNameChangeHandler():void
{
	if (this.userCollectionNames.indexOf(this.userCollectionNameInput.text) > 0) {
		this.userCollectionComboBox.selectedItem = this.userCollectionNameInput.text;
	} else {
		this.userCollectionComboBox.selectedIndex = -1;
	}
}

private function selectCardChangeHandler():void
{
	_currentCard = this.cardHList.selectedItem as Card;
	cardViewUnit.card = _currentCard;
	
	if (_currentCard.type == null) {
		this.baseTypeViewStack.selectedIndex = 0;
	}
	
	ITypeEditor(this.baseTypeViewStack.selectedChild).cardType = this._currentCard.type;
	
}

private function cardTypeChangeHandler():void
{
	
}
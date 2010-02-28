// ActionScript file
import org.hamster.magic.common.models.CardCollection;
import org.hamster.magic.common.services.DataService;

private static const DS:DataService = DataService.getInstance();

[Bindable]
public var cardCollectionNames:Array;

[Bindable]
public var userCollectionNames:Array;

private function completeHandler():void
{
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
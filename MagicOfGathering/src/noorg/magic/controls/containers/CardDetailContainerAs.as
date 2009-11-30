// ActionScript file
import noorg.magic.controls.unit.actions.ActionEditorBase;
import noorg.magic.models.Card;
import noorg.magic.utils.Constants;

private var _card:Card;
[Bindable]
private var _name:String;
[Bindable]
private var _descrption:String;

public static function popup(card:Card):void
{
	new Constants;
}

public function set card(value:Card):void
{
	this._card = value;
	this._name = value.name;
	this._descrption = value.oracleText;
	
	if (this.mainCardImg != null) {
		this.mainCardImg.card = value;
	}
}

public function get card():Card
{
	return this._card;
}

private function completeHandler():void
{
	if (card != null) {
		this.mainCardImg.card = card;
	}
}

private function editCardHandler():void
{
	this.mainViewStack.selectedIndex = 1;
	this.cardEditorContainer.card = this.card;
}

private function viewStackChangedHandler():void
{
//	if (this.mainViewStack.selectedIndex == 1) {
//		cardEditContainer.removeAllChildren();
//	}
}


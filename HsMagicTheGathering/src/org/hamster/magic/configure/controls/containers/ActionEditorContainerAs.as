// ActionScript file
import org.hamster.magic.common.models.action.CardAction;


private var _cardAction:CardAction;

public function set cardAction(value:CardAction):void
{
	this._cardAction = value;
	if (this.initialized) {
		applySimpleActions();
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
		applySimpleActions();
	}
}

private function applySimpleActions():void
{
	this.simpleActionEditorContainer.removeAllChildren();
	
	
}
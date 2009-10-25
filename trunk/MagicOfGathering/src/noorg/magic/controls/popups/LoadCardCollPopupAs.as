// ActionScript file
import mx.managers.PopUpManager;

import noorg.magic.commands.CommandWrapper;
import noorg.magic.commands.impl.LoadUserCollCmd;
import noorg.magic.models.Card;
import noorg.magic.services.DataService;
import noorg.magic.utils.GlobalUtil;

import org.hamster.commands.ICommand;
import org.hamster.commands.events.CommandEvent;

private const DS:DataService = DataService.getInstance();

private function loadCardHandler():void
{
	if (DS.userCollNames.length > 0) {
		var str:String = collNameComboBox.selectedItem as String;
		if (str.length > 0) {
			var cmd:ICommand = CommandWrapper.loadUserColl(str);
			cmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCompleteHandler);
			GlobalUtil.popUpMask(this.resourceManager.getString('main', 'loading'));
		}
	}
}

private function cancelHandler():void
{
	cancelPopup();
}

private function loadCompleteHandler(evt:CommandEvent):void
{
	GlobalUtil.removePopUpMask();
	var cmd:LoadUserCollCmd = LoadUserCollCmd(evt.currentTarget);
	DS.selectedCards.removeAll();
	for each (var card:Card in cmd.cards) {
		DS.selectedCards.addItem(card);
	}
	cancelPopup();
}

private function cancelPopup():void
{
	GlobalUtil.removePopup(this);
}
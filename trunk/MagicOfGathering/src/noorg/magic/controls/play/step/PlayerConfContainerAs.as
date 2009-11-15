// ActionScript file
import noorg.magic.commands.impl.LoadUserCollCmd;
import noorg.magic.events.StepCtrlEvent;
import noorg.magic.models.CardCollection;
import noorg.magic.models.Player;
import noorg.magic.services.DataService;
import noorg.magic.utils.GlobalUtil;
import noorg.magic.utils.ModelFactory;

import org.hamster.commands.events.CommandEvent;
import org.hamster.commands.impl.CommandQueue;

public static const DS:DataService = DataService.getInstance();

public var player:Player;

private function completeHandler():void
{
	this.colorPicker.selectedColor = uint(Math.random() * 256 * 256 * 256);
}

public function load():void
{
	var collCmd:LoadUserCollCmd = new LoadUserCollCmd();
	collCmd.name = this.collectionComboBox.selectedItem as String;
	collCmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCompleteHandler);
	collCmd.execute();
	
}

public function loadCompleteHandler(evt:CommandEvent):void
{
	var collCmd:LoadUserCollCmd = LoadUserCollCmd(evt.currentTarget);
	var cardColl:CardCollection = new CardCollection();
	cardColl.name = collCmd.name;
	cardColl.cards = collCmd.cards;
	
	this.player = ModelFactory.createPlayer(cardColl);
	this.player.color = Number(this.colorPicker.value);
	
	this.dispatchEvent(new StepCtrlEvent(StepCtrlEvent.LOAD_COMPLETE));
}
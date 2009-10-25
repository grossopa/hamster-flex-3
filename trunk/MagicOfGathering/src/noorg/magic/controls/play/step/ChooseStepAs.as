// ActionScript file
import noorg.magic.commands.impl.LoadUserCollCmd;
import noorg.magic.events.StepCtrlEvent;
import noorg.magic.models.CardCollection;
import noorg.magic.services.DataService;
import noorg.magic.utils.GlobalUtil;
import noorg.magic.utils.ModelFactory;

import org.hamster.commands.events.CommandEvent;
import org.hamster.commands.impl.CommandQueue;

private const DS:DataService = DataService.getInstance();

private function goNextHandler():void
{
	var coll1Cmd:LoadUserCollCmd = new LoadUserCollCmd();
	coll1Cmd.name = this.player1ComboBox.selectedItem as String;
	var coll2Cmd:LoadUserCollCmd = new LoadUserCollCmd();
	coll2Cmd.name = this.player2ComboBox.selectedItem as String;
	var queue:CommandQueue = new CommandQueue([coll1Cmd, coll2Cmd]);
	queue.addEventListener(CommandEvent.COMMAND_RESULT, loadCompleteHandler);
	queue.execute();
	
	GlobalUtil.popUpMask(this.resourceManager.getString('main', 'loading'));
}

private function loadCompleteHandler(evt:CommandEvent):void
{
	GlobalUtil.removePopUpMask();
	
	var cmd:CommandQueue = CommandQueue(evt.currentTarget);
	var coll1Cmd:LoadUserCollCmd = LoadUserCollCmd(cmd.cmdArray[0]);
	var coll2Cmd:LoadUserCollCmd = LoadUserCollCmd(cmd.cmdArray[1]);
	var cardColl1:CardCollection = new CardCollection();
	cardColl1.name = coll1Cmd.name;
	cardColl1.cards = coll1Cmd.cards;
	var cardColl2:CardCollection = new CardCollection();
	cardColl2.name = coll2Cmd.name;
	cardColl2.cards = coll2Cmd.cards;
	DS.playerRed = ModelFactory.createPlayer(cardColl1);
	DS.playerBlue = ModelFactory.createPlayer(cardColl2);
	
	this.dispatchEvent(new StepCtrlEvent(StepCtrlEvent.NEXT));
	
	
}
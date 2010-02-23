// ActionScript file
import mx.collections.ArrayCollection;

import org.hamster.commands.events.CommandEvent;
import org.hamster.commands.impl.CommandQueue;
import org.hamster.magic.common.commands.LoadUserCollCmd;
import org.hamster.magic.common.models.CardCollection;
import org.hamster.magic.common.services.DataService;
import org.hamster.magic.play.controls.utils.PlayerFactory;

private static const DS:DataService = DataService.getInstance();
[Bindable]
private var userCollNames:ArrayCollection;

private function completeHandler():void
{
	userCollNames = DS.userCollNames;
}

private function startGameHandler():void
{
	var cardColl1:CardCollection;
	var cardColl2:CardCollection;
	
	var loadUserColl1Cmd:LoadUserCollCmd = new LoadUserCollCmd();
	loadUserColl1Cmd.name = this.player1CardCollComboBox.selectedItem.toString();
	var loadUserColl2Cmd:LoadUserCollCmd = new LoadUserCollCmd();
	loadUserColl2Cmd.name = this.player2CardCollComboBox.selectedItem.toString();	
	var queue:CommandQueue = new CommandQueue([loadUserColl1Cmd, loadUserColl2Cmd]);
	queue.addEventListener(CommandEvent.COMMAND_RESULT, queueResultHandler);
	queue.execute();
//		if (cardCollection.name == this.player1CardCollComboBox.selectedItem.toString()) {
//			DS.player1 = PlayerFactory.createPlayer(cardCollection);
//		}
//		if (cardCollection.name == this.player2CardCollComboBox.selectedItem.toString()) {
//			DS.player2 = PlayerFactory.createPlayer(cardCollection);
//		}
//	this.dispatchEvent(new Event("startGame"));
}

private function queueResultHandler(evt:CommandEvent):void
{
	var cmd1:LoadUserCollCmd = LoadUserCollCmd(evt.currentTarget.cmdArray[0]);
	var cmd2:LoadUserCollCmd = LoadUserCollCmd(evt.currentTarget.cmdArray[1]);
	var cardColl1:CardCollection = new CardCollection();
	cardColl1.name = cmd1.name;
	cardColl1.cards = cmd1.cards;
	var cardColl2:CardCollection = new CardCollection();
	cardColl2.name = cmd2.name;
	cardColl2.cards = cmd2.cards;
	DS.player1 = PlayerFactory.createPlayer(cardColl1);
	DS.player2 = PlayerFactory.createPlayer(cardColl2);
	
	this.dispatchEvent(new Event("startGame"));	
}
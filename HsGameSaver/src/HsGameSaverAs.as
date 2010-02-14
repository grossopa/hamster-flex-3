// ActionScript file
import org.hamster.commands.events.CommandEvent;
import org.hamster.gamesaver.commands.LoadUserDataCmd;
import org.hamster.gamesaver.models.Game;
import org.hamster.gamesaver.services.DataService;

private static const DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	this.resourceManager.localeChain = ["zh_CN"];
 	var loadCmd:LoadUserDataCmd = new LoadUserDataCmd();
	loadCmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCompleteHandler);
	loadCmd.execute();
}

private function loadCompleteHandler(evt:CommandEvent):void
{
	var loadCmd:LoadUserDataCmd = LoadUserDataCmd(evt.currentTarget);
	DS.setUserDataXML(loadCmd.xml);
	for each (var game:Game in DS.gameArray) {
		this.gameContainer.addGameUnit(game);
	}
}
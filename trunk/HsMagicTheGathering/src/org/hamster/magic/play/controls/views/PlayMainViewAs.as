// ActionScript file
import org.hamster.magic.common.services.DataService;

private static const DS:DataService = DataService.getInstance();

private function init():void
{
	player1Container.player = DS.player1;
}

private function completeHandler():void
{
	
}
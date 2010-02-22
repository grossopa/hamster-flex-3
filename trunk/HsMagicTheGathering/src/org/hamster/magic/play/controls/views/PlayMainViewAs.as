// ActionScript file
import org.hamster.magic.common.services.DataService;

private static const DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	player1Container.player = DS.player1;
}
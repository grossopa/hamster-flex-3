// ActionScript file
import flash.events.Event;

private function startGameHandler():void
{
	this.dispatchEvent(new Event("startGame"));
}
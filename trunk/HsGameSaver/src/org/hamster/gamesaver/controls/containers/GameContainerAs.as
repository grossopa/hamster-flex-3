// ActionScript file
import org.hamster.gamesaver.controls.units.GameUnit;
import org.hamster.gamesaver.events.ChildComponentEvent;
import org.hamster.gamesaver.models.Game;

private function addGameHandler():void
{
	addGameUnit(new Game());
}

public function addGameUnit(game:Game):void
{
	var gameUnit:GameUnit = new GameUnit();
	gameUnit.game = game;
	gameUnit.addEventListener(ChildComponentEvent.DELETE, gameDeleteHandler);
	this.mainContainer.addChildAt(gameUnit, 0);	
}

private function gameDeleteHandler(evt:ChildComponentEvent):void
{
	var gameUnit:GameUnit = GameUnit(evt.currentTarget);
	gameUnit.removeEventListener(ChildComponentEvent.DELETE, gameDeleteHandler);
	this.mainContainer.removeChild(gameUnit);
}
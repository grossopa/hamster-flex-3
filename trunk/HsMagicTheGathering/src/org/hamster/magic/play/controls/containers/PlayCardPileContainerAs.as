// ActionScript file
import flash.events.MouseEvent;

import org.hamster.magic.play.controls.units.PlayCardPileUnit;

private function changeFocusHandler(evt:MouseEvent):void
{
	var unit:PlayCardPileUnit = PlayCardPileUnit(evt.currentTarget);
	galleryPileUnit.isSelected = false;
	graveyardPileUnit.isSelected = false;
	outPileUnit.isSelected = false;
	unit.isSelected = true;
}
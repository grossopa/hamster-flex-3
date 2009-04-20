
import flash.events.Event;

import org.hamster.effects.advancedviewstack.Adv9AVS;
import org.hamster.effects.advancedviewstack.AdvDoorAVS;
import org.hamster.effects.advancedviewstack.AdvSplit9AVS;
import org.hamster.effects.advancedviewstack.AdvSplitAVS;
import org.hamster.effects.advancedviewstack.FadeAVS;
import org.hamster.effects.advancedviewstack.FadeScaleAVS;
import org.hamster.effects.advancedviewstack.IrisAVS;
import org.hamster.effects.advancedviewstack.MoveAVS;
import org.hamster.effects.advancedviewstack.RotateScaleYAVS;
import org.hamster.effects.advancedviewstack.ScaleXAVS;
import org.hamster.effects.advancedviewstack.ScaleYAVS;
import org.hamster.effects.advancedviewstack.SkewAVS;


[Bindable] private var comboBoxList:Array;

private function completeHandler():void
{
	comboBoxList = ["AdvSplit9AVS", "AdvSplitAVS", "FadeAVS", "FadeScaleAVS",
			"IrisAVS", "MoveAVS", "RotateScaleYAVS", "ScaleXAVS", "ScaleYAVS", "Skew"
			,"AdvDoorAVS", "Adv9AVS"];
	comboBox.selectedIndex = 2;
	avs.duration = 1000;
}

private function goPageLeft():void
{
	avs.goPage(avs.viewStack.selectedIndex - 1);
	refCanvas.setMainDisObj(avs.viewStack.selectedChild);
	refCanvas.paintReflection();
}

private function goPageRight():void
{
	avs.goPage(avs.viewStack.selectedIndex + 1);
	refCanvas.setMainDisObj(avs.viewStack.selectedChild);
	refCanvas.paintReflection();
}

private function selectHandler(event:Event):void
{
	switch(comboBox.selectedIndex) {
		case 0:
			avs.setAnimationClass(AdvSplit9AVS);
			break;
		case 1:
			avs.setAnimationClass(AdvSplitAVS);
			break;
		case 2:
			avs.setAnimationClass(FadeAVS);
			break;
		case 3:
			avs.setAnimationClass(FadeScaleAVS);
			break;
		case 4:
			avs.setAnimationClass(IrisAVS);
			break;
		case 5:
			avs.setAnimationClass(MoveAVS);
			break;
		case 6:
			avs.setAnimationClass(RotateScaleYAVS);
			break;
		case 7:
			avs.setAnimationClass(ScaleXAVS);
			break;
		case 8:
			avs.setAnimationClass(ScaleYAVS);
			break;
		case 9:
			avs.setAnimationClass(SkewAVS);
			break;
		case 10:
			avs.setAnimationClass(AdvDoorAVS);
			break;
		case 11:
			avs.setAnimationClass(Adv9AVS);
			break;
	}
}


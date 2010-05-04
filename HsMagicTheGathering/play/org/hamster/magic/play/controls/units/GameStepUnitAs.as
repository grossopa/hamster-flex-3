// ActionScript file
import org.hamster.magic.common.models.utils.GameStep;

private const stepTextArray:Array = [
	{name : "重置阶段", value : GameStep.S_11_UNTAP},
	{name : "维护阶段", value : GameStep.S_12_UPKEEP},
	{name : "抓牌阶段", value : GameStep.S_13_DRAW},
	{name : "出牌阶段", value : GameStep.P_2_MAIN},
	{name : "战斗阶段", value : GameStep.P_3_COMBAT},
	{name : "结束阶段", value : GameStep.S_13_DRAW},
	{name : "清理阶段", value : GameStep.S_11_UNTAP},
];

private function gotoNextStepHandler():void
{
}
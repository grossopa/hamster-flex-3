import flash.filesystem.File;

import mx.events.FlexEvent;

import org.hamster.commands.events.CommandEvent;
import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.components.images.CreatureImage;
import org.hamster.mapleCard.base.constants.CreatureStatus;
import org.hamster.mapleCard.base.model.IBattleFieldData;
import org.hamster.mapleCard.base.model.battleField.CreatureBattleFieldData;
import org.hamster.mapleCard.base.utils.FileUtil;
import org.hamster.mapleCard.main.components.battleField.BattleFieldContainer;
import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;

private var _testCreatureImage:CreatureImage;

protected function windowedapplication1_applicationCompleteHandler(event:FlexEvent):void
{
	var battleFieldContainer:BattleFieldContainer = new BattleFieldContainer();
	sv2.addChild(battleFieldContainer);
}

public function testCreatureImageLoaderCommand():void
{
	_testCreatureImage = new CreatureImage("0100100");
	_testCreatureImage.x = this.sv.numChildren * 50;
	_testCreatureImage.direction = (this.sv.numChildren % 2 == 0) ? "left" : "right";
	
	var battleFieldData:CreatureBattleFieldData = new CreatureBattleFieldData();
	battleFieldData.maxHp = 10;
	battleFieldData.hp = 3;
	
	
	
	var battleFieldItem:BattleFieldItem = new BattleFieldItem();
	battleFieldItem.battleFieldData = battleFieldData;
	battleFieldItem.mainImage = _testCreatureImage;
	
	this.sv.addChild(battleFieldItem);
}

private function creatureDie():void
{
	this._testCreatureImage.status = CreatureStatus.DIE;
}

private function creatureStand():void
{
	this._testCreatureImage.status = CreatureStatus.STAND;
}

private function creatureHit():void
{
	this._testCreatureImage.status = CreatureStatus.HIT;
}

private function creatureWalk():void
{
	this._testCreatureImage.status = CreatureStatus.MOVE;
}

private function cilCmdResultHandler(evt:CommandEvent):void
{
	var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
}

private function cilCmdFaultHandler(evt:CommandEvent):void
{
	var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
}
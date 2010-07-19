import flash.filesystem.File;

import mx.events.FlexEvent;

import org.hamster.commands.events.CommandEvent;
import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.components.images.CreatureImage;
import org.hamster.mapleCard.base.constants.CreatureStatus;
import org.hamster.mapleCard.base.model.IBattleFieldItemData;
import org.hamster.mapleCard.base.model.battleField.CreatureBattleFieldItemData;
import org.hamster.mapleCard.base.utils.FileUtil;
import org.hamster.mapleCard.main.components.battleField.BattleFieldContainer;
import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;

private var _battleFieldContainer:BattleFieldContainer;
private var _battleFieldItem:BattleFieldItem;
private var _testCreatureImage:CreatureImage;

protected function windowedapplication1_applicationCompleteHandler(event:FlexEvent):void
{
	_battleFieldContainer = new BattleFieldContainer();
	sv2.addChild(_battleFieldContainer);
}

public function testCreatureImageLoaderCommand():void
{
	_testCreatureImage = new CreatureImage("0100100");
	_testCreatureImage.x = this.sv.numChildren * 50;
	_testCreatureImage.direction = (this.sv.numChildren % 2 == 0) ? "left" : "right";
	
	var battleFieldData:CreatureBattleFieldItemData = new CreatureBattleFieldItemData();
	battleFieldData.maxHp = 10;
	battleFieldData.hp = 3;
	
	_battleFieldItem = new BattleFieldItem();
	_battleFieldItem.battleFieldData = battleFieldData;
	_battleFieldItem.mainImage = _testCreatureImage;
	
	this._battleFieldContainer.addBattleFieldItem(_battleFieldItem, 0, 0);
}

private function moveBattleFieldItem():void
{
	_battleFieldItem.battleFieldData.setIndex(2, 4);
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
import flash.filesystem.File;

import org.hamster.commands.events.CommandEvent;
import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.components.images.CreatureImage;
import org.hamster.mapleCard.base.constants.CreatureStatus;
import org.hamster.mapleCard.base.utils.FileUtil;

private var _testCreatureImage:CreatureImage;

public function testCreatureImageLoaderCommand():void
{
	_testCreatureImage = new CreatureImage("0100100");
	_testCreatureImage.x = this.sv.numChildren * 50;
	_testCreatureImage.direction = (this.sv.numChildren % 2 == 0) ? "left" : "right";
	this.sv.addChild(_testCreatureImage);
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
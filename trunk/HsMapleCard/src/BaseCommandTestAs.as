import flash.filesystem.File;

import org.hamster.commands.events.CommandEvent;
import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.components.images.CreatureImage;
import org.hamster.mapleCard.base.constants.CreatureStatusConst;
import org.hamster.mapleCard.base.utils.FileUtil;

private var _testCreatureImage:CreatureImage;

public function testCreatureImageLoaderCommand():void
{
	var cmd:CreatureImageLoaderCmd = new CreatureImageLoaderCmd();
	cmd.dir = FileUtil.creatureDir.nativePath + File.separator 
		+ "0100100";
//	cmd.addEventListener(CommandEvent.COMMAND_RESULT, cilCmdResultHandler);
//	cmd.addEventListener(CommandEvent.COMMAND_FAULT, cilCmdFaultHandler);
//	cmd.execute();
	_testCreatureImage = new CreatureImage("0100100");
	this.sv.addChild(_testCreatureImage);
}

private function creatureDie():void
{
	this._testCreatureImage.status = CreatureStatusConst.DIE;
}

private function creatureStand():void
{
	this._testCreatureImage.status = CreatureStatusConst.STAND;
}

private function creatureHit():void
{
	this._testCreatureImage.status = CreatureStatusConst.HIT;
}

private function creatureWalk():void
{
	this._testCreatureImage.status = CreatureStatusConst.MOVE;
}

private function cilCmdResultHandler(evt:CommandEvent):void
{
	var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
}

private function cilCmdFaultHandler(evt:CommandEvent):void
{
	var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
}
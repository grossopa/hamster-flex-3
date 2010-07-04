import flash.filesystem.File;

import org.hamster.commands.events.CommandEvent;
import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.components.images.CreatureImage;
import org.hamster.mapleCard.base.utils.FileUtil;

public function testCreatureImageLoaderCommand():void
{
	var cmd:CreatureImageLoaderCmd = new CreatureImageLoaderCmd();
	cmd.dir = FileUtil.creatureDir.nativePath + File.separator 
		+ "0100100";
//	cmd.addEventListener(CommandEvent.COMMAND_RESULT, cilCmdResultHandler);
//	cmd.addEventListener(CommandEvent.COMMAND_FAULT, cilCmdFaultHandler);
//	cmd.execute();
	var creatureImage:CreatureImage = new CreatureImage("0100100");
	this.sv.addChild(creatureImage);
}

private function cilCmdResultHandler(evt:CommandEvent):void
{
	var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
}

private function cilCmdFaultHandler(evt:CommandEvent):void
{
	var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
}
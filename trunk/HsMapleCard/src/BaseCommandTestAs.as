import flash.filesystem.File;

import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.utils.FileUtil;

public function testCreatureImageLoaderCommand():void
{
	var cmd:CreatureImageLoaderCmd = new CreatureImageLoaderCmd();
	cmd.dir = FileUtil.creatureDir.nativePath + File.separator 
		+
}
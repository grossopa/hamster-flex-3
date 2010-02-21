package org.hamster.magic.common.commands
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.magic.common.models.Card;

	public class SaveDetailToFileCmd extends AbstractCommand
	{
		public var card:Card;
		
		public function SaveDetailToFileCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var infoFile:File = new File(card.imgPath.replace(/.jpg$/, ".xml"));
			var infoFs:FileStream = new FileStream();
			infoFs.openAsync(infoFile, FileMode.WRITE);
			infoFs.writeUTFBytes(card.toXMLString());
			super.result(null);
		}
		
	}
}
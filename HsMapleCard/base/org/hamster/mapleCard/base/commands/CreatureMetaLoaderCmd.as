package org.hamster.mapleCard.base.commands
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	import org.hamster.mapleCard.base.utils.FileUtil;
	
	public class CreatureMetaLoaderCmd extends BaseFileLoaderCmd
	{
		public var creatureCard:CreatureCard;
		
		public function CreatureMetaLoaderCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			this.filePath = FileUtil.creatureMetaDir.nativePath 
				+ File.separator + key + ".xml";
			super.execute();
		}
		
		override public function result(data:Object):void
		{
			var xml:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
			this.creatureCard = new CreatureCard();
			this.creatureCard.decode(xml);
			
			super.afterResult(data);
		}
	}
}
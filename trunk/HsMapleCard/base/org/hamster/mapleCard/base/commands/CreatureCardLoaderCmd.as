package org.hamster.mapleCard.base.commands
{
	import flash.filesystem.File;
	
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	import org.hamster.mapleCard.base.utils.FileUtil;
	
	public class CreatureCardLoaderCmd extends BaseFileLoaderCmd
	{
		public var creatureCard:CreatureCard;
		
		public function CreatureCardLoaderCmd()
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
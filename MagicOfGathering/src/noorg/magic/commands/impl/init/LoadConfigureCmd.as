package noorg.magic.commands.impl.init
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	import noorg.magic.models.CardCollectionMeta;
	import noorg.magic.utils.Properties;
	
	import org.hamster.commands.AbstractCommand;

	public class LoadConfigureCmd extends AbstractCommand
	{
		public static const CONF_XML:String = File.applicationDirectory.nativePath + File.separator + "conf" + File.separator + "conf.xml";
		public var file:File;
		
		public function LoadConfigureCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			file = new File(CONF_XML);
			var fs:FileStream = new FileStream();
			fs.addEventListener(Event.COMPLETE, loadCompleteHandler);
			fs.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			fs.openAsync(file, FileMode.READ);
		}
		
		private function loadCompleteHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			var xml:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
			
			// database configuration
			Properties.databasePath = xml.database.path;
			Properties.databasePath = File.applicationDirectory.resolvePath(Properties.databasePath).nativePath;
			Properties.databasePassword = xml.database.password;
			
			// i18n configuration
			Properties.locales = new Array();
			for each (var locale:XML in xml.locales.children()) {
				Properties.locales.push(locale.toString());
			}
			ResourceManager.getInstance().localeChain = [Properties.defaultLocale];
			ResourceManager.getInstance().update();
			
			// game configuration
			Properties.cardNum = xml.game.child("card-num")[0];
			
			// load known collection information
			for each (var knownCollXML:XML in xml.collections.children()) {
				var cardCollMeta:CardCollectionMeta = new CardCollectionMeta();
				cardCollMeta.name = knownCollXML.@name;
				cardCollMeta.fromIndex = knownCollXML.@from;
				cardCollMeta.toIndex = knownCollXML.attribute("to");
				Properties.knownCardCollections.push(cardCollMeta);
			}

			super.result(null);
		}
		
		private function ioErrorHandler(evt:Event):void
		{
			Alert.show(evt.toString());
			
			super.fault(null);
		}
		
	}
}
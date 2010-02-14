package org.hamster.gamesaver.services
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	import org.hamster.gamesaver.models.Game;
	import org.hamster.gamesaver.utils.Constants;
	
	public class DataService
	{
		private static var _instance:DataService;
		
		public static function getInstance():DataService
		{
			if (_instance == null) {
				_instance = new DataService();
			}
			return _instance;
		}
		
		public function DataService()
		{
		}
		
		[Bindable]
		public var driveArray:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var gameArray:ArrayCollection = new ArrayCollection();
		
		public var copyPath:File = new File();
		public var zipEnabled:Boolean = false;
		
		public function isNameExists(name:String):Boolean
		{
			for each (var game:Game in this.gameArray) {
				if (game.name == name) {
					return true;
				}
			}
			return false;
		}
		
		public function autoIncreaseGameName(name:String):String
		{
			var reg:RegExp = /(?:\()([0-9])+(?:\))$/;
			var reg2:RegExp = /(\()([0-9])+(\))$/;
			var obj:Object = reg.exec(name);
			var num:Number;
			if (obj == null) {
				return name + " (1)";
			} else if (obj is String) {
				num = parseFloat(s);
				if (num == 0 || isNaN(num)) {
					num = 1;
				} else {
					num++;
				}
				
				return name.replace(obj.toString(), "") + " (" + num.toString() + ")";
			} else if (obj is Array) {
				for each (var s:String in obj) {
					num = parseFloat(s);
					if (num == 0 || isNaN(num)) {
						continue;
					} else {
						num++;
						var t:String = name.replace(reg2, "");
						return t + "(" + num.toString() + ")";
					}
				}
			}
			return name + " (1)";
		}
		
		public function getUserDataXML():XML
		{
			var locale:String = String(ResourceManager.getInstance().localeChain[0]);
			var xml:XML = new XML(<user copy-path={this.copyPath.nativePath}
					zip-enabled={this.zipEnabled} locale={locale}></user>);
			
			var gamesXML:XML = new XML(<games></games>);
			for each (var game:Game in this.gameArray) {
				gamesXML.appendChild(game.encodeXML());
			}
			
			xml.appendChild(gamesXML);
			return xml;
		}
		
		public function setUserDataXML(xml:XML):void
		{
			gameArray.removeAll();
			try {
				copyPath = new File(xml.attribute("copy-path"));
			} catch (e:Error) {
				
			}
			this.zipEnabled = xml.attribute("zip-enabled") as String == "true";
			var gamesXML:XML = xml.child("games")[0];
			var locale:String = xml.attribute("locale");
			if (Constants.LOCALES.indexOf(locale) < 0) {
				locale = String(Constants.LOCALES[0]);
			}
			ResourceManager.getInstance().localeChain = [locale];
			for each (var xmlChild:XML in gamesXML.children()) {
				var game:Game = new Game();
				game.decodeXML(xmlChild);
				gameArray.addItem(game);
			}
		}

	}
}
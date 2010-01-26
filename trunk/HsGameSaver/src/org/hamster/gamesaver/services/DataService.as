package org.hamster.gamesaver.services
{
	import mx.collections.ArrayCollection;
	
	import org.hamster.gamesaver.models.Game;
	
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
		
		public function getUserDataXML():XML
		{
			var xml:XML = new XML(<user></user>);
			
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
			var gamesXML:XML = xml.child("games")[0];
			
			for each (var xmlChild:XML in gamesXML.children()) {
				var game:Game = new Game();
				game.decodeXML(xmlChild);
				gameArray.addItem(game);
			}
			
			
		}

	}
}
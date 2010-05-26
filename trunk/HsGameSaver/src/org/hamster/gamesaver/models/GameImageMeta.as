package org.hamster.gamesaver.models
{
	import flash.filesystem.File;

	public class GameImageMeta
	{
		public var path:String;
		public var keywordList:Array = new Array();
		
		public function decode(xml:XML):void
		{
			this.path = xml.attribute('path');
			var keywordListXML:XML = xml.child('keywords')[0];
			keywordList = new Array();
			if (keywordListXML != null) {
				for each (var keywordXML:XML in keywordListXML.children()) {
					keywordList.push(keywordXML.attribute('value'));
				}
			}
		}
		
		public function encode():XML
		{
			var xml:XML = new XML(<image path={this.path}></image>);
			var keywordListXML:XML = new XML(<keywords></keywords>);
			for each (var s:String in keywordList) {
				keywordListXML.appendChild(new XML(<keyword value={s}></keyword>));
			}
			return xml;
		}
	}
}
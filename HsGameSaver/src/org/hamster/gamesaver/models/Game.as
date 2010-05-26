package org.hamster.gamesaver.models
{
	import mx.utils.StringUtil;
	
	public class Game
	{
		public function Game()
		{
		}
		
		public var name:String;
		public var path:String;
		public var savePath:String;
		public var imagePath:String;
		
		
		public var includes:Array = new Array();
		public var excludes:Array = new Array();
		
		public var includeSubFolder:Boolean;
		
		public function parseIncludes(s:String):void
		{
			parseString2Array(s, this.includes);
		}
		
		public function parseExcludes(s:String):void
		{
			parseString2Array(s, this.excludes);
		}
		
		private function parseString2Array(str:String, targetArray:Array, split:String = ","):void 
		{
			var sArray:Array = str.split(split);
			for each (var s:String in sArray) {
				s = StringUtil.trim(s);
				if (s != "") {
					targetArray.push(s);
				}
			}
			
		}
		
		public function encodeXML():XML
		{
			var xml:XML = new XML(<game name={this.name} save-path={this.savePath} 
					path={this.path} include-sub-folder={this.includeSubFolder} image-path={this.imagePath}></game>);
			var includesXML:XML = new XML(<includes></includes>);
			var s:String;
			for each (s in includes) {
				includesXML.appendChild(XML(<include>{s}</include>));
			}
			var excludesXML:XML = new XML(<excludes></excludes>);
			for each (s in excludes) {
				excludesXML.appendChild(XML(<exclude>{s}</exclude>));
			}
			xml.appendChild(includesXML);
			xml.appendChild(excludesXML);
			return xml;
		}
		
		public function decodeXML(xml:XML):void
		{
			this.path = xml.attribute("path");
			this.savePath = xml.attribute("save-path");
			this.imagePath = xml.attribute("image-path");
			this.name = xml.attribute("name");
			 
			this.includeSubFolder = xml.attribute("include-sub-folder") == "true";
			
			var childXML:XML;
			var s:String;
			
			this.includes = new Array();
			var includesXML:XML = xml.child("includes")[0];
			for each (childXML in includesXML.children()) {
				s = childXML;
				this.includes.push(s);
			}
			
			this.excludes = new Array();
			var excludesXML:XML = xml.child("excludes")[0];
			for each (childXML in excludesXML.children()) {
				s = childXML;
				this.excludes.push(s);
			}	
		}

	}
}
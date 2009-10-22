package noorg.magic.models
{
	import flash.utils.ByteArray;
	
	public class Card
	{
		public var pid:int;
		public var name:String;
		public var imgUrl:String;
		public var imgPath:String;
		public var oracleText:String;
		public var collection:String;
		
		// for extended usage
		public var isSelected:Boolean;
		public var count:int;
		
		public function toString():String
		{
			return '[pid:'+ pid + ', name:' + name + ", imgUrl:" + imgUrl + ", oracleText:" + oracleText + "]";
		}
		
		public function getBaseInfo():String
		{
			return '[pid:'+ pid + ', name:' + name + ", imgUrl:" + imgUrl + ']';
		}
		
		public function decodeXML(xml:XML):void
		{
			this.pid = xml.@pid;
			this.name = xml.@name;
			this.imgUrl = xml.@url;
			this.oracleText = xml.toString();
		}
		
		public function decodeUserXML(xml:XML):void
		{
			this.pid = xml.@pid;
			this.name = xml.@name;
			this.imgUrl = xml.@url;
			this.collection = xml.@collection;
			this.count = xml.@count;
			this.isSelected = xml.attribute("is-selected");
			this.imgPath = xml.attribute("img-path");
			this.oracleText = xml;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML(<card pid={pid} name={name} url={imgUrl}>{oracleText}</card>);
			return xml;
		}
		
		public function toUserXML():XML
		{
			var xml:XML = new XML(<card pid={pid} name={name} url={imgUrl} 
					collection={collection} count={count} is-selected={isSelected}
					img-path={imgPath}>{oracleText}</card>);
			return xml;			
		}
		
		public function toXMLString():String
		{
			var xml:XML = this.toXML();
			return xml.toXMLString();
		}
		
	}
}
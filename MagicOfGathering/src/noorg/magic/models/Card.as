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
		
		public function toXML():XML
		{
			var xml:XML = new XML(<card pid={pid} name={name} url={imgUrl}>{oracleText}</card>);
			return xml;
		}
		
		public function toXMLString():String
		{
			var xml:XML = this.toXML();
			return xml.toXMLString();
		}
	}
}
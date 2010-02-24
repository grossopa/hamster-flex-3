package org.hamster.magic.common.models
{
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.magic.common.commands.LoadCardXMLCmd;
	import org.hamster.magic.common.models.base.AbstractModelSupport;
	
	
	public class Card extends AbstractModelSupport
	{
		public var pid:int;
		public var name:String;
		public var imgUrl:String;
		public var imgPath:String;
		public var oracleText:String;
		public var collection:String;
		
		public var count:int;
		public var isSelected:Boolean;
		
		/**
		 * card detail information
		 */
		public const magic:Magic = new Magic();
		
		public function decodeXML(xml:XML):void
		{
			this.pid = xml.@pid;
			this.name = xml.@name;
			this.imgUrl = xml.@url;
			this.oracleText = xml.attribute("oracle-text");
			this.magic.decodeString(xml.attribute("magic-cost"));
			
//			if (xml.elements("type")[0] != null) {
//				var typeName:int = xml.elements("type")[0].attribute("name");
//				var cls:Class = CardType.getType(typeName);
//				this.type = new cls();
//				this.type.decodeXML(xml.elements("type")[0]);
//			}
//			
//			if (xml.elements("actions")[0] != null) {
//				this.actionManager.decodeXML(xml.elements("actions")[0]);
//			}
		}
		
		public function decodeUserXML(xml:XML):void
		{
			this.collection = xml.@collection;
			this.pid = xml.@pid;
			this.count = xml.@count;
			this.isSelected = xml.attribute("is-selected") == "true";
			
//			var cmd:LoadCardXMLCmd = new LoadCardXMLCmd();
//			cmd.collection = this.collection;
//			cmd.pid = this.pid;
//			cmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCardXMLCompleteHandler);
//			cmd.addEventListener(CommandEvent.COMMAND_FAULT, loadCardXMLFailedHandler);
//			cmd.execute();
		}
		
		private function loadCardXMLCompleteHandler(evt:CommandEvent):void
		{
			var cmd:LoadCardXMLCmd = LoadCardXMLCmd(evt.currentTarget);
            cmd.removeEventListener(CommandEvent.COMMAND_RESULT, loadCardXMLCompleteHandler);
            cmd.removeEventListener(CommandEvent.COMMAND_FAULT, loadCardXMLFailedHandler);
			var xml:XML = cmd.xml;
			this.decodeXML(xml);
		}
		
		private function loadCardXMLFailedHandler(evt:CommandEvent):void
		{
            var cmd:LoadCardXMLCmd = LoadCardXMLCmd(evt.currentTarget);
            cmd.removeEventListener(CommandEvent.COMMAND_RESULT, loadCardXMLCompleteHandler);
            cmd.removeEventListener(CommandEvent.COMMAND_FAULT, loadCardXMLFailedHandler);			
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML(<card pid={pid} name={name} url={imgUrl}
					magic-cost={this.magic.encodeString()} oracle-text={oracleText}>
					</card>);
//			if (this.type != null) {
//				xml.appendChild(this.type.encodeXML());
//			}
//			xml.appendChild(this._actionManager.encodeXML());
			return xml;
		}
		
		public function toUserXML():XML
		{
			var xml:XML = new XML(<card></card>);
			xml.@["pid"] = this.pid;
			xml.@["collection"] = this.collection;
			xml.@["count"] = this.count;
			xml.@["is-selected"] = this.isSelected;
			return xml;
		}
		
//		public function toXMLString():String
//		{
//			var xml:XML = this.toXML();
//			return xml.toXMLString();
//		}
		
	}
}
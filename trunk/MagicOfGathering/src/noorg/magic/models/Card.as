package noorg.magic.models
{
	import noorg.magic.models.actions.ActionManager;
	import noorg.magic.models.actions.base.ICardAction;
	import noorg.magic.models.base.AbstractModelSupport;
	import noorg.magic.models.staticValue.CardType;
	import noorg.magic.models.types.base.ICardType;
	
	public class Card extends AbstractModelSupport
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
		
		/**
		 * card detail information
		 */
		private var _magicPool:MagicPool = new MagicPool();
		private var _actionManager:ActionManager = new ActionManager();
		private var _cardType:ICardType;
		
		public function set magicPool(value:MagicPool):void
		{
			this._magicPool = value;
		}
		
		public function get magicPool():MagicPool
		{
			return this._magicPool;
		}
		
		public function set type(value:ICardType):void
		{
			this._cardType = value;
		}
		
		public function get type():ICardType
		{
			return this._cardType;
		}
		
		public function set actionManager(value:ActionManager):void
		{
			this._actionManager = value;
		}
		
		public function get actionManager():ActionManager
		{
			return _actionManager;
		}
		
		public function get actionList():Array
		{
			return this._actionManager.actionList;
		}
		
		public function addAction(iCardAction:ICardAction):void
		{
			this._actionManager.addAction(iCardAction);
		}
		
		public function getAction(index:int):ICardAction
		{
			return ICardAction(this._actionManager.actionList[index]);
		}
		
		public function removeAllActions():void
		{
			this._actionManager.removeAllActions();
		}
		
		public function decodeXML(xml:XML):void
		{
			this.pid = xml.@pid;
			this.name = xml.@name;
			this.imgUrl = xml.@url;
			this.oracleText = xml.attribute("oracle-text");
			this.magicPool.decodeString(xml.attribute("magic-cost"));
			
			if (xml.elements("type")[0] != null) {
				var typeName:int = xml.elements("type")[0].attribute("name");
				var cls:Class = CardType.getType(typeName);
				this.type = new cls();
				this.type.decodeXML(xml.elements("type")[0]);
			}
			
			if (xml.elements("actions")[0] != null) {
				this.actionManager.decodeXML(xml.elements("actions")[0]);
			}
		}
		
		public function decodeUserXML(xml:XML):void
		{
			this.decodeXML(xml);
			
			this.collection = xml.@collection;
			this.count = xml.@count;
			this.isSelected = xml.attribute("is-selected");
			this.imgPath = xml.attribute("img-path");
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML(<card pid={pid} name={name} url={imgUrl}
					magic-cost={this.magicPool.encodeString()} oracle-text={oracleText}>
					</card>);
			if (this.type != null) {
				xml.appendChild(this.type.encodeXML());
			}
			xml.appendChild(this._actionManager.encodeXML());
			return xml;
		}
		
		public function toUserXML():XML
		{
			var xml:XML = this.toXML();
			
			xml.@["collection"] = this.collection;
			xml.@["count"] = this.count;
			xml.@["is-selected"] = this.isSelected;
			xml.@["img-path"] = this.imgPath;
			
			return xml;			
		}
		
		public function toXMLString():String
		{
			var xml:XML = this.toXML();
			return xml.toXMLString();
		}
		
	}
}
package noorg.magic.models
{
	import noorg.magic.actions.ActionManager;
	import noorg.magic.actions.base.ICardAction;
	import noorg.magic.models.base.AbstractModelSupport;
	
	public class Card extends AbstractModelSupport
	{
		public var pid:int;
		public var name:String;
		public var imgUrl:String;
		public var imgPath:String;
		public var oracleText:String;
		public var collection:String;
		public var magicPool:MagicPool = new MagicPool();
		// for extended usage
		public var isSelected:Boolean;
		public var count:int;
		
		private var _actionManager:ActionManager = new ActionManager();
		
		public function addAction(iCardAction:ICardAction):void
		{
			this._actionManager.actionList.push(iCardAction);
		}
		
		public function getAction(index:int):ICardAction
		{
			return ICardAction(this._actionManager.actionList[index]);
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
			
			this.magicPool.decodeString(xml.attribute("magic"));
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
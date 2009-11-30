package noorg.magic.actions
{
	import noorg.magic.actions.base.ICardAction;
	import noorg.magic.actions.magicPool.MagicPoolChangeAction;
	import noorg.magic.models.staticValue.ActionType;
	import noorg.magic.utils.MapCollector;
	
	public class ActionManager
	{
		public static var actionMap:MapCollector;
		
		public static function getActionByString(actType:String):Class
		{
			if (actionMap == null) {
				actionMap = new MapCollector();
				actionMap.put(ActionType.MAGIC_POOL_CHANGE, MagicPoolChangeAction);
			}
			
			return Class(actionMap.getValue(actType));
		}
				
		
		public var actionList:Array;
		
		public function ActionManager()
		{
			actionList = new Array();
		}
		
		public function removeAllActions():void
		{
			this.actionList = new Array();
		}
		
		public function getAction(index:int):ICardAction
		{
			return ICardAction(actionList[index]);
		}
		
		public function get length():int
		{
			return actionList.length;
		}
		
		public function encodeXML():XML
		{
			var xml:XML = new XML(<actions></actions>);
			
			for each (var action:ICardAction in this.actionList) {
				xml.appendChild(action.encodeXML());
			}
			
			return xml;
		}
		
		public function decodeXML(xml:XML):void
		{
			this.actionList = new Array();
			for each (var xmlChild:XML in xml.children()) {
				var s:String = xmlChild.attribute("act-type");
				var cls:Class = ActionManager.getActionByString(s);
				var action:ICardAction = new cls();
				action.decodeXML(xmlChild);
				this.actionList.push(action);
			}			
		}
		
		public function clone():ActionManager
		{
			var result:ActionManager = new ActionManager();
			for each (var action:ICardAction in this.actionList) {
				result.actionList.push(action.clone());
			}
			return result;
		}

	}
}
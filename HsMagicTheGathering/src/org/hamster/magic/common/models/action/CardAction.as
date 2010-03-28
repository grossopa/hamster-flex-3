package org.hamster.magic.common.models.action
{
	import org.hamster.common.utils.ArrayUtil;
	import org.hamster.magic.common.models.Magic;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	import org.hamster.magic.common.models.action.utils.SimpleActionFactory;
	import org.hamster.magic.common.utils.XMLStringUtil;
	
	public class CardAction
	{
		public var steps:Array;
		public var cost:Magic = new Magic();
		public var targets:Array;
		public var targetsNumber:int = 1;
		public var simpleActions:Array;
		
		public function CardAction()
		{
		}
		
		public function execute():void
		{
		}
		
		public function clone():CardAction
		{
			var result:CardAction = new CardAction();
			result.steps = ArrayUtil.shallowCopyArray(this.steps);
			result.cost = this.cost.clone();
			result.targets = ArrayUtil.shallowCopyArray(this.targets);
			result.targetsNumber = this.targetsNumber;
			var actions:Array = new Array();
			for each (var simpleAction:ISimpleAction in this.simpleActions) {
				actions.push(simpleAction.clone());
			}
			return result;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML(<action></action>);
			xml.@['steps'] = XMLStringUtil.encodeArray2String(this.steps);
			xml.@['cost'] = this.cost.encodeString();
			xml.@['targets'] = XMLStringUtil.encodeArray2String(this.targets);
			xml.@['targets-number'] = this.targetsNumber;
			
			var sActionXML:XML = new XML(<simple></simple>);
			if (this.simpleActions != null) {
				for each (var sAction:ISimpleAction in this.simpleActions) {
					sActionXML.appendChild(sAction.toXML());
				}
			}
			
			return xml;
		}
		
		public function decodeXML(xml:XML):void
		{
			this.steps = XMLStringUtil.string2int(xml.attribute('steps'));
			this.cost = new Magic();
			this.cost.decodeString(xml.attribute('cost'));
			this.targets = XMLStringUtil.string2int(xml.attribute('targets'));
			this.targetsNumber = xml.attribute('targets-number');
			
			var simpleActionArray:Array = new Array();
			var simpleXMLList:XMLList = xml.child('simple');
			for each (var simpleXML:XML in simpleXMLList) {
				var simpleAction:ISimpleAction = 
						SimpleActionFactory
						.createAction(simpleXML.attribute('type'));
				simpleAction.decodeXML(simpleXML);
				simpleActionArray.push(simpleAction);
			}
			this.simpleActions = simpleActionArray;
		}

	}
}
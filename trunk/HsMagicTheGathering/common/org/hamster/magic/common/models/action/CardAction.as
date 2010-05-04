package org.hamster.magic.common.models.action
{
	import org.hamster.common.utils.ArrayUtil;
	import org.hamster.magic.common.models.Magic;
	import org.hamster.magic.common.models.PlayCard;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	import org.hamster.magic.common.models.action.utils.SimpleActionFactory;
	import org.hamster.magic.common.utils.XMLStringUtil;
	
	public class CardAction
	{
		public var name:String;
		
		public var steps:Array;
		public var cost:Magic = new Magic();
		public var targets:Array;
		public var targetsNumber:int = 1;
		private var _simpleActions:Array;
		public var notNeedTap:Boolean;
		
		public function set simpleActions(value:Array):void
		{
			this._simpleActions = value;
		}
		
		public function get simpleActions():Array
		{
			return this._simpleActions;
		}
		
		public function CardAction()
		{
		}
		
		public function execute(step:int, tars:Array = null):void
		{
			if (this.steps.indexOf(step) < 0) {
				return;
			}
			
			var t:Object;
			
			for each (var simpleAction:ISimpleAction in this.simpleActions) {
				for each (t in tars) {
					simpleAction.execute(t);
				}
			}
			
		}
		
		public function clone():CardAction
		{
			var result:CardAction = new CardAction();
			result.name = this.name;
			result.steps = ArrayUtil.shallowCopyArray(this.steps);
			result.cost = this.cost.clone();
			result.targets = ArrayUtil.shallowCopyArray(this.targets);
			result.targetsNumber = this.targetsNumber;
			result.notNeedTap = this.notNeedTap;
			var actions:Array = new Array();
			for each (var simpleAction:ISimpleAction in this.simpleActions) {
				actions.push(simpleAction.clone());
			}
			result.simpleActions = actions;
			return result;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML(<action></action>);
			xml.@['name'] = this.name;
			xml.@['steps'] = XMLStringUtil.encodeArray2String(this.steps);
			xml.@['cost'] = this.cost.encodeString();
			xml.@['targets'] = XMLStringUtil.encodeArray2String(this.targets);
			xml.@['targets-number'] = this.targetsNumber;
			xml.@['not-need-tap'] = this.notNeedTap;
			var sActionXML:XML = new XML(<simple></simple>);
			if (this.simpleActions != null) {
				for each (var sAction:ISimpleAction in this.simpleActions) {
					sActionXML.appendChild(sAction.toXML());
				}
			}
			xml.appendChild(sActionXML);
			return xml;
		}
		
		public function decodeXML(xml:XML):void
		{
			this.name = xml.attribute('name');
			this.steps = XMLStringUtil.string2int(xml.attribute('steps'));
			this.cost = new Magic();
			this.cost.decodeString(xml.attribute('cost'));
			this.targets = XMLStringUtil.string2int(xml.attribute('targets'));
			this.targetsNumber = xml.attribute('targets-number');
			this.notNeedTap = xml.attribute('not-need-tap') == 'true';
			
			var simpleActionArray:Array = new Array();
			var simpleXMLList:XML = xml.child('simple')[0];
			if (simpleXMLList != null) {
				for each (var simpleXML:XML in simpleXMLList.children()) {
					var typeString:String = simpleXML.attribute('type');
					var simpleAction:ISimpleAction = 
							SimpleActionFactory
							.createAction(typeString);
					simpleAction.decodeXML(simpleXML);
					simpleActionArray.push(simpleAction);
				}
			}
			this.simpleActions = simpleActionArray;
		}

	}
}
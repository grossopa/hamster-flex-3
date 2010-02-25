package org.hamster.magic.common.models.action.simpleAction
{
	import org.hamster.magic.common.models.action.simpleAction.base.BaseSimpleAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	import org.hamster.magic.common.models.base.ILifeTarget;

	public class SimpleLifeChangeAction extends BaseSimpleAction
	{
		public var target:ILifeTarget;
		public var changeValue:int;
		
		public function SimpleLifeChangeAction()
		{
			super();
		}
		
		override public function execute():void
		{
			target.life += changeValue;
		}
		
		override public function clone():ISimpleAction
		{
			var result:SimpleLifeChangeAction = new SimpleLifeChangeAction();
			result.target = this.target;
			result.changeValue = this.changeValue;
			return result;
		}
		
		override public function decodeXML(xml:XML):void
		{
			this.changeValue = xml.attribute("change-value");
		}
		
		override public function toXML():XML
		{
			var xml:XML = super.toXML();
			xml.attribute("change-value") = this.changeValue;
			xml.attribute("type") = "SimpleLifeChangeAction";
			return xml;
		}
		
		
	}
}
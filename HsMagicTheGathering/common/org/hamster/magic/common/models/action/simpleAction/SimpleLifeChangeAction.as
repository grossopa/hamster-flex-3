package org.hamster.magic.common.models.action.simpleAction
{
	import org.hamster.magic.common.models.PlayCard;
	import org.hamster.magic.common.models.action.simpleAction.base.BaseSimpleAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;
	import org.hamster.magic.common.models.base.ILifeTarget;

	public class SimpleLifeChangeAction extends BaseSimpleAction
	{
		public var changeValue:int;
		
		public function SimpleLifeChangeAction()
		{
			super();
			this._type = "SimpleLifeChangeAction";
		}
		
		override public function execute(tar:Object):void
		{
			if (tar is ILifeTarget) {
				ILifeTarget(tar).life += changeValue;
			} else if (tar is PlayCard) {
				ILifeTarget(tar.type).life += changeValue;
			}
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
			xml.@["change-value"] = this.changeValue;
			xml.@["type"] = "SimpleLifeChangeAction";
			return xml;
		}
		
	}
}
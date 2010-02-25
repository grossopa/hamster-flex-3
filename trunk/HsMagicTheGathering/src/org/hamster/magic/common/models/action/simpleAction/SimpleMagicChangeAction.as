package org.hamster.magic.common.models.action.simpleAction
{
	import org.hamster.magic.common.models.Magic;
	import org.hamster.magic.common.models.action.simpleAction.base.BaseSimpleAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;

	public class SimpleMagicChangeAction extends BaseSimpleAction
	{
		public var target:Magic;
		
		public const changeValue:Magic = new Magic();
		
		public function SimpleMagicChangeAction()
		{
			super();
		}
		
		override public function execute():void
		{
			target.red += changeValue.red;
			target.black += changeValue.black;
			target.blue += changeValue.blue;
			target.white += changeValue.white;
			target.green += changeValue.green;
			target.colorless += changeValue.colorless;
		}
		
		override public function clone():ISimpleAction
		{
			var result:SimpleMagicChangeAction = new SimpleMagicChangeAction();
			result.target = this.target;
			result.changeValue.decodeString(this.changeValue.encodeString());
			return result;
		}
		
		override public function decodeXML(xml:XML):void
		{
			var s:String = xml.attribute("change-value");
			this.changeValue.decodeString(s);
		}
		
		override public function toXML():XML
		{
			var xml:XML = super.toXML();
			xml.attribute("change-value") = this.changeValue.encodeString();
			xml.attribute("type") = "SimpleMagicChangeAction";
			return xml;
		}
		
	}
}
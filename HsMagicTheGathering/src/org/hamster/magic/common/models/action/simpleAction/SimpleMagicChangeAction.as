package org.hamster.magic.common.models.action.simpleAction
{
	import org.hamster.magic.common.models.Magic;
	import org.hamster.magic.common.models.Player;
	import org.hamster.magic.common.models.action.simpleAction.base.BaseSimpleAction;
	import org.hamster.magic.common.models.action.simpleAction.base.ISimpleAction;

	public class SimpleMagicChangeAction extends BaseSimpleAction
	{
		public const changeValue:Magic = new Magic();
		
		public function SimpleMagicChangeAction()
		{
			super();
		}
		
		override public function execute():void
		{
			var targetMagic:Magic;
			if (target is Magic) {
				targetMagic = Magic(target);
			} else if (target is Player) {
				targetMagic = Magic(target.magic);
			}
			
			targetMagic.red += changeValue.red;
			targetMagic.black += changeValue.black;
			targetMagic.blue += changeValue.blue;
			targetMagic.white += changeValue.white;
			targetMagic.green += changeValue.green;
			targetMagic.colorless += changeValue.colorless;
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
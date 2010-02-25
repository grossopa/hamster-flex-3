package org.hamster.magic.common.models.action.simpleAction.base
{
	// instance = new _global[myString]();
	public class BaseSimpleAction implements ISimpleAction
	{
		public function BaseSimpleAction()
		{
		}
		
		public function execute():void
		{
			
		}
		
		public function clone():ISimpleAction
		{
			return null;
		}
		
		public function decodeXML(xml:XML):void
		{
			
		}
		
		public function toXML():XML
		{
			return new XML(<simple-action></simple-action>);;
		}

	}
}
package org.hamster.magic.common.models
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.models.base.AbstractModelSupport;
	
	public class Cards extends AbstractModelSupport
	{
		public var name:String;
		public var cards:ArrayCollection;
		
		override public function toString():String
		{
			return this.name;
		}

	}
}
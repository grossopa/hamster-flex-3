package org.hamster.magic.common.models
{
	import mx.collections.ArrayCollection;
	
	import org.hamster.magic.common.models.base.AbstractModelSupport;
	
	public class CardCollection extends AbstractModelSupport
	{
		public var name:String;
		public var cards:ArrayCollection;
		
		override public function toString():String
		{
			return this.name;
		}

	}
}
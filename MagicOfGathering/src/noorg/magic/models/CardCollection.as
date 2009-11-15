package noorg.magic.models
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.models.base.AbstractModelSupport;
	
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
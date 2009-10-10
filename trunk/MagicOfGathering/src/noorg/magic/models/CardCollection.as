package noorg.magic.models
{
	import mx.collections.ArrayCollection;
	
	public class CardCollection
	{
		public var name:String;
		public var cards:ArrayCollection;
		
		public function toString():String
		{
			return this.name;
		}	

	}
}
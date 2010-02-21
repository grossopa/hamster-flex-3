package org.hamster.magic.common.models
{
	public class CardCollectionMeta
	{
		public var name:String;
		public var fromIndex:int;
		public var toIndex:int;

		public function toString():String
		{
			return name + " (" + fromIndex + "," + toIndex + ")";
		}
	}
}
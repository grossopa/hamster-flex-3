package noorg.models.album
{
	import flash.utils.ByteArray;
	
	public class BackgroundImage
	{
		private var _source:ByteArray;
		
		public function get source():ByteArray
		{
			return _source;
		}
		
		public function BackgroundImage(byteArray:ByteArray)
		{
			_source = byteArray;
		}
		
		public function clone():BackgroundImage
		{
			var result:BackgroundImage = new BackgroundImage(this._source);
			return result;
		}
		
	}
}
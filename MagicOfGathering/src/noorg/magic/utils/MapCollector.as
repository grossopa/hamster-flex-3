package noorg.magic.utils
{
	import mx.collections.ArrayCollection;
	
	public class MapCollector
	{
		private const _keys:ArrayCollection = new ArrayCollection();
		private const _values:ArrayCollection = new ArrayCollection();
		
		public function MapCollector()
		{
		}
		
		public function put(key:Object, value:Object):Boolean
		{
			if (!_keys.contains(key)) {
				_keys.addItem(key);
				_values.addItem(value);
				return true;
			} else {
				return false;
			}
		}
		
		public function getValue(key:Object):Object
		{
			return _values.getItemAt(_keys.getItemIndex(key));
		}
		
		public function removeByKey(key:Object):Object
		{
			if (_keys.contains(key)) {
				var index:int = _keys.getItemIndex(key);
				_keys.removeItemAt(index);
				return _values.removeItemAt(index);
			}
			return null;
		}
		
		public function removeByValue(value:Object):Object
		{
			if (_values.contains(value)) {
				var index:int = _values.getItemIndex(value);
				_keys.removeItemAt(index);
				return _values.removeItemAt(index);
			}
			return null;
		}
		
	}
}
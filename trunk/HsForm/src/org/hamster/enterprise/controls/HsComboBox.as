package org.hamster.enterprise.controls
{
	import mx.collections.ICollectionView;
	import mx.controls.ComboBox;
	
	public class HsComboBox extends ComboBox implements IInputField
	{
		public function HsComboBox()
		{
			super();
		}
		
		public function get stringValue():String
		{
			if (this.selectedItem is String) {
				return this.selectedItem.toString();
			} else if (selectedItem.hasOwnProperty('value')) {
				return this.selectedItem.value;
			} else if (selectedItem.hasOwnProperty(labelField)) {
				return this.selectedItem[labelField];
			} else {
				return this.selectedItem.toString();
			}
		}
		
		private var _required:Boolean;
		private var _displayedText:String;
		
		public function set required(value:Boolean):void
		{
			_required = value;
		}
		
		public function get required():Boolean
		{
			return _required;
		}
		
		public function set displayedText(value:String):void
		{
			this._displayedText = value;
		}
		
		public function get displayedText():String
		{
			return this._displayedText;
		}
		
		public function set emptyText(value:String):void
		{
			this.prompt = value;
		}
		
		public function get emptyText():String
		{
			return this.prompt;
		}
		
		public function set mainData(value:Object):void
		{
			if (value != null) {
				var coll:ICollectionView = ICollectionView(this.dataProvider);
				
				for (var i:int = 0; i < coll.length; i++) {
					var obj:Object = coll[i];
					if ((obj.hasOwnProperty('value') && obj.value == value)
							|| obj == value) {
						this.selectedIndex = i;
					}
				}
			}
		}
		
		public function get mainData():Object
		{
			return this.selectedItem;
		}
		
		
		
	}
}
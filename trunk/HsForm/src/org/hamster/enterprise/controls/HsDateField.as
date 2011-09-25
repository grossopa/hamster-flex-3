package org.hamster.enterprise.controls
{
	import mx.controls.DateField;
	import mx.formatters.DateFormatter;
	
	public class HsDateField extends DateField implements IInputField
	{
		public static var globalDisplayedDateFormatter:DateFormatter;
		public static var globalResultDateFormatter:DateFormatter;
		
		private var _diaplayedDateFormatter:DateFormatter;
		private var _resultDateFormatter:DateFormatter;
		
		private var _required:Boolean;
		
		public function set diaplayedDateFormatter(value:DateFormatter):void
		{
			if (_diaplayedDateFormatter != value) {
				_diaplayedDateFormatter = value;
			}
		}
		
		public function get diaplayedDateFormatter():DateFormatter
		{
			return _diaplayedDateFormatter;
		}
		
		private function get availableDisplayedFormatter():DateFormatter
		{
			if (_diaplayedDateFormatter == null 
					&& globalDisplayedDateFormatter == null 
					&& globalResultDateFormatter == null) {
				globalDisplayedDateFormatter = new DateFormatter();
				return globalDisplayedDateFormatter;
			} else if (_diaplayedDateFormatter == null 
					&& globalDisplayedDateFormatter == null) {
				return globalResultDateFormatter;
			} else if (_diaplayedDateFormatter == null) {
				return globalDisplayedDateFormatter;
			}
			return _diaplayedDateFormatter;
		}
		
		
		public function set resultDateFormatter(value:DateFormatter):void
		{
			if (_resultDateFormatter != value) {
				_resultDateFormatter = value;
			}
		}
		
		public function get resultDateFormatter():DateFormatter
		{
			return _resultDateFormatter;
		}
		
		private function get availableResultFormatter():DateFormatter
		{
			if (_resultDateFormatter == null 
					&& globalResultDateFormatter == null 
					&& globalDisplayedDateFormatter == null ) {
				globalResultDateFormatter = new DateFormatter();
				return globalResultDateFormatter;
			} else if (_resultDateFormatter == null 
					&& globalResultDateFormatter == null) {
				return globalDisplayedDateFormatter;
			} else if (_resultDateFormatter == null) {
				return globalResultDateFormatter;
			}
			return _resultDateFormatter;
		}
		
		public function HsDateField()
		{
			super();
			
			this.labelFunction = this.labelFunc;
		}
		
		public function labelFunc(date:Date):String
		{
			var fmt:DateFormatter = this.availableDisplayedFormatter;
			return fmt.format(date);
		}
		
		public function set mainData(value:Object):void
		{
			var fmt:DateFormatter = this.availableResultFormatter;
			if (value is String) {
				DateField.stringToDate(String(value), fmt.formatString);
			} else if (value is Date) {
				this.selectedDate = value as Date;
			}
		}
		
		public function get mainData():Object
		{
			return this.selectedDate;
		}
		
		public function get stringValue():String
		{
			var fmt:DateFormatter = this.availableResultFormatter;
			return fmt.format(this.selectedDate);
		}
		
		public function set required(value:Boolean):void
		{
			_required = value;
		}
		
		public function get required():Boolean
		{
			return _required;
		}
		
		public function set emptyText(value:String):void
		{
		}
		
		public function get emptyText():String
		{
			return null;
		}
	}
}
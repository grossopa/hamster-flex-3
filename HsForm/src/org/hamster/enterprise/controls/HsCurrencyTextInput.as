package org.hamster.enterprise.controls
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	
	import mx.controls.TextInput;
	import mx.formatters.CurrencyFormatter;
	
	[ResourceBundle("formatters")]
	[ResourceBundle("SharedResources")]
	
	public class HsCurrencyTextInput extends HsTextInput implements IInputField
	{
		public static var globalCurrFormatter:CurrencyFormatter;
		
		protected static var NUMBERS:Array = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
		
		private var _currencyFormatter:CurrencyFormatter;
		public function set currencyFormatter(value:CurrencyFormatter):void
		{
			if (_currencyFormatter != value) {
				_currencyFormatter = value;
			}
		}
		
		public function get currencyFormatter():CurrencyFormatter
		{
			return _currencyFormatter;
		}
		
		private function get availableFormatter():CurrencyFormatter
		{
			if (_currencyFormatter == null && globalCurrFormatter == null) {
				globalCurrFormatter = new CurrencyFormatter();
				return globalCurrFormatter;
			} else if (_currencyFormatter == null) {
				return globalCurrFormatter;
			}
			return _currencyFormatter;
		}
		
		private var _maxDecimalLength:Object;
		
		public function set maxDecimalLength(value:Object):void
		{
			_maxDecimalLength = value != null ?
				value :
				resourceManager.getString(
					"SharedResources", "maxDecimalLength");
		}
		
		[Inspectable(category="General", defaultValue="null")]
		
		public function get maxDecimalLength():Object
		{
			return _maxDecimalLength;
		}
		
		private var _maxIntLength:Object;
		
		public function set maxIntLength(value:Object):void
		{
			_maxIntLength = value != null ?
				value :
				resourceManager.getString(
					"SharedResources", "maxIntLength");
		}
		
		[Inspectable(category="General", defaultValue="null")]
		
		public function get maxIntLength():Object
		{
			return _maxIntLength;
		}
		
		private var _maxValue:Object;
		
		public function set maxValue(value:Object):void
		{
			_maxValue = value != null ?
				value :
				resourceManager.getString(
					"SharedResources", "currencyMaxValue");
		}
		
		[Inspectable(category="General", defaultValue="null")]
		
		public function get maxValue():Object
		{
			return _maxValue;
		}
		
		private var _minValue:Object;
		
		public function set minValue(value:Object):void
		{
			_minValue = value != null ?
				value :
				resourceManager.getString(
					"SharedResources", "currencyMinValue");
		}
		
		[Inspectable(category="General", defaultValue="null")]
		
		public function get minValue():Object
		{
			return _minValue;
		}
		
		
		public function HsCurrencyTextInput()
		{
			super();
		}
		
		override protected function focusInHandler(event:FocusEvent):void
		{
			super.focusInHandler(event);
			var fmt:CurrencyFormatter = this.availableFormatter;
			var decTo:String = fmt.decimalSeparatorTo;
			// this.restrict = "0-9-" + decTo;
			
			if (text.length > 0) {
				var thuTo:String = fmt.thousandsSeparatorTo;
				var symbo:String = fmt.currencySymbol;
				this.text = text.split(thuTo).join('').replace(symbo, '');
			}
			
		}
		
		override protected function focusOutHandler(event:FocusEvent):void
		{
			super.focusOutHandler(event);
			if (text.length > 0) {
				var fmt:CurrencyFormatter = this.availableFormatter;
				var thuTo:String = fmt.thousandsSeparatorTo;
				var decTo:String = fmt.decimalSeparatorTo; 
				var symbo:String = fmt.currencySymbol;
				this.text = fmt.format(stringValue);
			}
		}
		
		
		override protected function textInputHandler(evt:TextEvent):void
		{
			var fmt:CurrencyFormatter = this.availableFormatter;
			
			var decTo:String = fmt.decimalSeparatorTo;
			var thuTo:String = fmt.thousandsSeparatorTo;
			var symbo:String = fmt.currencySymbol;
			
			var newInputText:String = evt.text;
			if ((NUMBERS.indexOf(newInputText) == -1 
				&& decTo != newInputText 
				&& thuTo != newInputText 
				&& symbo != newInputText
				&& "-" != newInputText)
				|| (this.text.indexOf(decTo) != -1 && newInputText == decTo)) {
				evt.preventDefault();
				return;
			}
			
			if (NUMBERS.indexOf(newInputText) != -1) {
				if (this.maxDecimalLength != null) {
					var decLen:int = int(maxDecimalLength);
					if (decLen >= 0 
						&& text.indexOf(decTo) != -1 
						&& selectionBeginIndex >= text.indexOf(decTo)) {
						var decStr:String = text.split(decTo)[1];
						if (decStr.length >= decLen) {
							evt.preventDefault();
							return;
						}
					}
				}
				
				if (this.maxIntLength != null) {
					var intLen:int = int(maxIntLength);
					if (intLen >= 0 
						&& (text.indexOf(decTo) == -1 
							|| (text.indexOf(decTo) != -1 
								&& selectionBeginIndex <= text.indexOf(decTo)))) {
						var intStr:String = text.split(decTo)[0];
						intStr = intStr.replace('-', '');
						if (intStr.length >= intLen) {
							evt.preventDefault();
							return;
						}
					}
				}
			}
		}
		
		override public function get stringValue():String
		{
			if (this.isShowingEmptyText) {
				return "";
			} else {
				var fmt:CurrencyFormatter = this.availableFormatter;
				var decTo:String = fmt.decimalSeparatorTo;
				var thuTo:String = fmt.thousandsSeparatorTo;
				var symbo:String = fmt.currencySymbol;
				var result:String = this.text.split(thuTo).join('').replace(symbo, '').replace(decTo, '.');
				return result;
			}
		}
		
		public function get intValue():int
		{
			return parseInt(stringValue);
		}
		
		public function get numberValue():Number
		{
			return parseFloat(stringValue);
		}
		
	}
}
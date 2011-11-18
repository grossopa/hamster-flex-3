package org.hamster.enterprise.controls
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	
	import mx.controls.TextInput;
	import mx.formatters.CurrencyFormatter;
	
	import org.hamster.enterprise.utils.HsMathUtil;
	import org.hamster.enterprise.utils.HsStringUtil;
	
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
		
		override public function set mainData(value:Object):void
		{
			if (_mainData != value) {
				var num:Number = Number(value);
				this._mainData = num;
				this._mainDataChanged = true;
				this.invalidateProperties();
			}
		}
		
		private var _maxDecimalLength:Object;
		private var _inputLimitChanged:Boolean = false;
		
		public function set maxDecimalLength(value:Object):void
		{
			if (_maxDecimalLength != value) {
				_maxDecimalLength = value;
				_inputLimitChanged = true;
				this.invalidateProperties();
			}
//					"SharedResources", "maxDecimalLength");
		}
		
		[Inspectable(category="General", defaultValue="null")]
		
		public function get maxDecimalLength():Object
		{
			return _maxDecimalLength;
		}
		
		private var _maxIntLength:Object;
		
		public function set maxIntLength(value:Object):void
		{
			if (_maxIntLength != value) {
				_maxIntLength = value;
				_inputLimitChanged = true;
				this.invalidateProperties();
			}
//					"SharedResources", "maxIntLength");
		}
		
		[Inspectable(category="General", defaultValue="null")]
		
		public function get maxIntLength():Object
		{
			return _maxIntLength;
		}
		
		private var _maxValue:Object;
		
		public function set maxValue(value:Object):void
		{
			if (_maxValue != value) {
				_maxValue = value;
				_inputLimitChanged = true;
				this.invalidateProperties();
			}
//					"SharedResources", "currencyMaxValue");
		}
		
		[Inspectable(category="General", defaultValue="null")]
		
		public function get maxValue():Object
		{
			return _maxValue;
		}
		
		private var _minValue:Object;
		
		public function set minValue(value:Object):void
		{
			if (_minValue != value) {
				_minValue = value;
				_inputLimitChanged = true;
				this.invalidateProperties();
			}
//					"SharedResources", "currencyMinValue");
		}
		
		[Inspectable(category="General", defaultValue="null")]
		
		public function get minValue():Object
		{
			return _minValue;
		}
		
//		/**
//		 *  @private
//		 *  Storage for the rounding property.
//		 */
//		private var _rounding:String;
//		private var _roundingChanged:Boolean = false;
//		
//		/**
//		 *  @private
//		 */
//		
//		[Inspectable(category="General", enumeration="none,up,down,nearest", defaultValue="null")]
//		
//		/**
//		 *  How to round the number.
//		 *  In ActionScript, the value can be <code>NumberBaseRoundType.NONE</code>, 
//		 *  <code>NumberBaseRoundType.UP</code>,
//		 *  <code>NumberBaseRoundType.DOWN</code>, or <code>NumberBaseRoundType.NEAREST</code>.
//		 *  In MXML, the value can be <code>"none"</code>, 
//		 *  <code>"up"</code>, <code>"down"</code>, or <code>"nearest"</code>.
//		 *
//		 *  @default NumberBaseRoundType.NONE
//		 *
//		 *  @see mx.formatters.NumberBaseRoundType
//		 */
//		public function get rounding():String
//		{
//			return _rounding;
//		}
//		
//		/**
//		 *  @private
//		 */
//		public function set rounding(value:String):void
//		{
//			if (_rounding != value) {
//				_rounding = value;
//				_roundingChanged = true;
//				this.invalidateProperties();
//			}
//			//		"formatters", "rounding");
//		}
		
		private var _usePercentSign:Boolean;
		private var _usePercentSignChanged:Boolean = false;
		
		public function set usePercentSign(value:Boolean):void
		{
			if (_usePercentSign != value) {
				_usePercentSign = value;
				_usePercentSignChanged = true;
				this.invalidateProperties();
			}
		}
		
		public function get usePercentSign():Boolean
		{
			return _usePercentSign;
		}
		
		private var _isShowingFormattedText:Boolean = true;
		private var _isShowingFormattedTextChanged:Boolean = false;
		
		public function get isShowingFormattedText():Boolean
		{
			return this._isShowingFormattedText;
		}
		
		override protected function commitProperties():void
		{
			var needSetText:Boolean = false;
			var num:Number;
			
			if ((_isShowingFormattedTextChanged || _usePercentSignChanged)
				&& !isShowingEmptyText && text.length > 0) {
				needSetText = true;
				num = this.mainData as Number;
//				var fmt:CurrencyFormatter = this.availableFormatter;
//				var thuTo:String = fmt.thousandsSeparatorTo;
//				var decTo:String = fmt.decimalSeparatorTo; 
//				var symbo:String = fmt.currencySymbol;
//				
//				if (_isShowingFormattedText && !usePercentSign) {
//					textField.text = fmt.format(stringValue);
//				} else if (_isShowingFormattedText && usePercentSign) {
//					textField.text = HsMathUtil.toFixed(numberValue * 100, int(maxDecimalLength), fmt.rounding) + "%";
//				} else {
//					textField.text = text.split(thuTo).join('').replace(symbo, '').replace('%', '');
//				}
//				
//				this.text = textField.text;
			}
			
			if (_inputLimitChanged || _mainDataChanged) {
				needSetText = true;
				num = this.mainData as Number;
			}
			
			if (isNaN(mainData as Number)) {
				this.text = "";
			} else if (needSetText) {
				var fmt:CurrencyFormatter = this.availableFormatter;
				var thuTo:String = fmt.thousandsSeparatorTo;
				var decTo:String = fmt.decimalSeparatorTo; 
				var symbo:String = fmt.currencySymbol;
				num = HsMathUtil.round(num, int(maxDecimalLength), fmt.rounding);
				
				if (isShowingFormattedText && !usePercentSign) {
					textField.text = fmt.format(num);
				} else if (isShowingFormattedText && usePercentSign) {
					textField.text = num.toString();
				} else {
					textField.text = text.split(thuTo).join('').replace(symbo, '').replace('%', '');
				}
				
				this.text = textField.text;
			}
			
			_inputLimitChanged 				= false;
			_mainDataChanged 				= false;
			_isShowingFormattedTextChanged  = false;
			_usePercentSignChanged 			= false;
			
			super.commitProperties();
		}
		
		public function HsCurrencyTextInput()
		{
			super();
		}
		
		override protected function focusInHandler(event:FocusEvent):void
		{
			super.focusInHandler(event);
			
			_isShowingFormattedText = false;
			_isShowingFormattedTextChanged = true;
			invalidateProperties();
		}
		
		override protected function focusOutHandler(event:FocusEvent):void
		{
			super.focusOutHandler(event);
			
			_isShowingFormattedText = true;
			_isShowingFormattedTextChanged = true;
			invalidateProperties();
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
		
		override protected function textChangeHandler(evt:Event):void
		{
			super.textChangeHandler(evt);
			
			var numberVal:Number = this.numberValue;
			if (!isNaN(numberVal)) {
				if (this.minValue != null) {
					var minVal:Number = Number(minValue);
					if (minVal > numberVal) {
						numberVal = minVal;
						this.text = numberVal.toString();
					}
				}
				
				if (this.maxValue != null) {
					var maxVal:Number = Number(maxValue);
					if (maxVal < numberVal) {
						numberVal = maxVal;
						this.text = numberVal.toString();
					}
				}
			}
			
			this._mainData = numberVal;
		}
		
		[Bindable("textChanged")]
		[CollapseWhiteSpace]
		[NonCommittingChangeEvent("change")]
		override public function get stringValue():String
		{
			if (this.isShowingEmptyText) {
				return "";
			} else {
				var fmt:CurrencyFormatter = this.availableFormatter;
				var decTo:String = fmt.decimalSeparatorTo;
				var thuTo:String = fmt.thousandsSeparatorTo;
				var symbo:String = fmt.currencySymbol;
				var result:String = this.text.split(thuTo).join('').replace(symbo, '').replace(decTo, '.').replace('%', '');
				return result;
			}
		}

		[Bindable("textChanged")]
		[CollapseWhiteSpace]
		[NonCommittingChangeEvent("change")]
		public function get intValue():int
		{
			return int(numberValue);
		}

		[Bindable("textChanged")]
		[CollapseWhiteSpace]
		[NonCommittingChangeEvent("change")]
		public function get numberValue():Number
		{
			if (usePercentSign) {
				return parseFloat(stringValue) / 100;
			} else {
				return parseFloat(stringValue);
			}
		}
	}
}
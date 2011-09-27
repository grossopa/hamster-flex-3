package org.hamster.enterprise.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	import mx.controls.TextInput;
	import mx.core.mx_internal;
	import mx.events.ValidationResultEvent;
	import mx.managers.IFocusManager;
	import mx.validators.RegExpValidator;
	import mx.validators.ValidationResult;
	
	use namespace mx_internal;
	
	[Event(name="hsRequiredChange", type="org.hamster.enterprise.controls.InputFieldEvent")]
	
	public class HsTextInput extends TextInput implements IInputField
	{
		public static const STATUS_NORMAL:String 	= "normal";
		public static const STATUS_EMPTY:String		= "empty";
		
		private var _oldTextColor:uint;
		private var _emptyTextColor:uint = 0xAAAAAA;
		private var _textStatus:String;
		
		public function get isShowingEmptyText():Boolean
		{
			return _textStatus == STATUS_EMPTY;
			// return textField.textColor == _emptyTextColor && textField.text == _emptyText;
		}
		
		public function setNormalText():void
		{
			if (_textStatus == STATUS_NORMAL) {
				return;
			}
			textField.setColor(_oldTextColor);
			_textStatus = STATUS_NORMAL;
		}
		
		public function setEmptyText():void
		{
			if (_textStatus == STATUS_EMPTY) {
				return;
			}
			textField.text = emptyText;
			_oldTextColor = textField.textColor;
			textField.setColor(_emptyTextColor);
			_textStatus = STATUS_EMPTY;
		}
		
		public function HsTextInput()
		{
			super();
			this.addEventListener(Event.CHANGE, textChangeHandler);
			this.addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
		}
		
		protected function textInputHandler(evt:TextEvent):void
		{
			// do nothing, sub class may override this function
		}
		
		protected function textChangeHandler(evt:Event):void
		{
			if (this.enableValidationRuntime) {
				this.validate();
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			// expression changed
			if (this.enableValidationRuntime || (_expressionChanged || this._requiredChanged)) {
				this.validate();
			}
			
			if (text == "" && systemManager.stage.focus != TextField(textField)) {
				setEmptyText();
			} else if (isShowingEmptyText) {
				// do nothing
				//setEmptyText();
			} else {
				setNormalText();
			}
			
			_requiredChanged = false;
			_expressionChanged = false;
			_enableValidationRuntimeChanged = false;
		}
		
		public function validate():ValidationResultEvent
		{
			if (!_regExpValidator) {
				_regExpValidator = new RegExpValidator();
			}
			_regExpValidator.required 	= this.required;
			_regExpValidator.source 	= this;
			_regExpValidator.enabled 	= this.enabled;
			_regExpValidator.expression = this.expression;
			_regExpValidator.noMatchError = this.noMatchErrorString;
			_regExpValidator.requiredFieldError = this.requiredFieldErrorString;
			_regExpValidator.property	= "text";
			//if (this._textStatus == STATUS_EMPTY && this.required) {
				//return _regExpValidator.validate("");
			//} else {
			var result:ValidationResultEvent = _regExpValidator.validate();
//			if (this.focusManager.getFocus() == this) {
//				this.focusManager.setFocus(this);
//			}
			var isError:Boolean = false;
			if (result.results) {
				for each (var resu:ValidationResult in result.results) {
					if (resu.isError) {
						isError = true;
						break;
					}
				}
			}
			
			setBorderColorForErrorString(isError);
			
			return result;
			//}
		}
		
		/**
		 *  @private
		 *  Set the appropriate borderColor based on errorString.
		 *  If we have an errorString, use errorColor. If we don't
		 *  have an errorString, restore the original borderColor.
		 */
		private function setBorderColorForErrorString(isError:Boolean):void
		{
			if (!isError)
			{
				if (!isNaN(origBorderColor))
				{
					setStyle("borderColor", origBorderColor);
					saveBorderColor = true;
				}
			}
			else
			{
				// Remember the original border color
				if (saveBorderColor)
				{
					saveBorderColor = false;
					origBorderColor = getStyle("borderColor");
				}
				
				setStyle("borderColor", getStyle("errorColor"));
			}
			
			styleChanged("themeColor");
			
			var focusManager:IFocusManager = super.focusManager;
			var focusObj:DisplayObject = focusManager ?
				DisplayObject(focusManager.getFocus()) :
				null;
			
			if (focusManager && 
				focusObj == this)
			{
				drawFocus(true);
			}
			
		}
		
		override protected function focusInHandler(event:FocusEvent):void
		{
			super.focusInHandler(event);
			
			if (isShowingEmptyText) {
				textField.text = "";
			}
			setNormalText();
			
			if (this.enableValidationRuntime) {
				this.validate();
			}
		}
		
		override protected function focusOutHandler(event:FocusEvent):void
		{
			super.focusOutHandler(event);
			
			if (textField.text == "") {
				setEmptyText();
			}
			
			if (this.enableValidationRuntime) {
				this.validate();
			}
		}
		
		private var _mainData:Object;
		private var _required:Boolean;
		private var _requiredChanged:Boolean;
		private var _emptyText:String;
		private var _regExpValidator:RegExpValidator;		
		private var _expression:String;
		private var _expressionChanged:Boolean;
		private var _noMatchErrorString:String;
		private var _requiredFieldErrorString:String;
		private var _enableValidationRuntime:Boolean;
		private var _enableValidationRuntimeChanged:Boolean;
		
		public function set mainData(value:Object):void
		{
			if (this._mainData != value) {
				this._mainData = value;
				this.text = value as String;
			}
			
		}
		public function get mainData():Object
		{
			return this._mainData;
		}
		
		public function set expression(value:String):void
		{
			if (_expression != value) {
				_expression = value;
				this.invalidateProperties();
			}
		}
		
		public function get expression():String
		{
			return _expression;
		}
		
		public function set noMatchErrorString(value:String):void
		{
			if (_noMatchErrorString != value) {
				_noMatchErrorString = value;
				_expressionChanged = true;
				this.invalidateProperties();
			}
		}
		
		public function get noMatchErrorString():String
		{
			return _noMatchErrorString;
		}
		
		public function set requiredFieldErrorString(value:String):void
		{
			if (_requiredFieldErrorString != value) {
				_requiredFieldErrorString = value;
				_expressionChanged = true;
				this.invalidateProperties();
			}
		}
		
		public function get requiredFieldErrorString():String
		{
			return this._requiredFieldErrorString;
		}
		
		public function set enableValidationRuntime(value:Boolean):void
		{
			if (_enableValidationRuntime != value) {
				_enableValidationRuntime = value;
				_enableValidationRuntimeChanged = true;
				this.invalidateProperties();
			}
		}
		
		public function get enableValidationRuntime():Boolean
		{
			return _enableValidationRuntime;
		}
		
		public function set required(value:Boolean):void
		{
			if (_required != value) {
				_required = value;
				_requiredChanged = true;
				if (this.hasEventListener(InputFieldEvent.HS_REQUIRED_CHANGE)) {
					this.dispatchEvent(new InputFieldEvent(InputFieldEvent.HS_REQUIRED_CHANGE));
				}
				this.invalidateProperties();
			}
		}
		public function get required():Boolean
		{
			return this._required;
		}
		
		public function set emptyText(value:String):void
		{
			if (this._emptyText != value) {
				this._emptyText = value;
				this.invalidateProperties();
			}
		}
		public function get emptyText():String
		{
			return this._emptyText;
		}
		
		public function get stringValue():String
		{
			return this.text;
		}
		
		
	}
}
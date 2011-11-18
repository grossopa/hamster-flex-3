package org.hamster.enterprise.controls
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.utils.StringUtil;
	
	import org.hamster.enterprise.utils.HsStringUtil;
	
	use namespace mx_internal;

	public class HsSerialNumberTextInput extends HsTextInput
	{
		
		private var _separator:String;
		private var _oldSeparator:String;
		private var _isSeparatorChanged:Boolean = false;
		
		private var _separatorIndexList:String = "";
		private var _isSeparatorIndexListChanged:Boolean = false;
		
		private var _oldTextLength:int = 0;
		
		public function set separator(value:String):void
		{
			if (_separator != value) {
				if (_separator != null) {
					_oldSeparator = _separator;
				}
				if (value == null) {
					_separator = "";
				} else {
					_separator = value;
				}
				_isSeparatorChanged = true;
				this.invalidateProperties();
			}
		}
		
		public function get separator():String
		{
			return _separator;
		}
		
		public function get oldSeparator():String
		{
			if (_oldSeparator == null) {
				return _separator;
			} else {
				return _oldSeparator;
			}
		}
		
		public function set separatorIndexList(value:String):void
		{
			if (_separatorIndexList != value) {
				_separatorIndexList = value;
				_isSeparatorIndexListChanged = true;
				this.invalidateProperties();
			}	
		}
		
		public function get separatorIndexList():String
		{
			return _separatorIndexList;
		}
		
		public function HsSerialNumberTextInput()
		{
			super();
		}
		
		override protected function formatTextHandler():void
		{
			var originalString:String = HsStringUtil.removeCharacter(this.text, oldSeparator);
			if (this.separator != null && this.separatorIndexList != null) {
				var i:int = 0;
				var tmpIdx:int;
				// change text
				var tempStr:String = originalString;
				var sepIndexArr:Array = this.separatorIndexList.split(',');
				
				for (i = 0; i < sepIndexArr.length; i++) {
					tmpIdx = parseInt(sepIndexArr[i]);
					if (tmpIdx >= originalString.length) {
						break;
					}
					tempStr = HsStringUtil.insertCharacter(tempStr, this.separator, tmpIdx + i * this.separator.length);
				}
					
				textField.text = tempStr;
				this.text = tempStr;
					
				// move begin & end index
				var tmpSelIndexStr:String;
				var offset:int = 0;
				if (this._oldTextLength < tempStr.length) {
					if (tempStr.substr(selectionBeginIndex - separator.length, separator.length) == this.separator) {
						this.selectionBeginIndex = this.selectionBeginIndex + separator.length;
						this.selectionEndIndex	 = this.selectionEndIndex + separator.length;
					}
				}
				
				_oldTextLength = this.text.length;
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if ((_isSeparatorChanged || _isSeparatorIndexListChanged)
					&& this.separatorIndexList != null) {
				formatTextHandler();
			}
			
			_isSeparatorChanged = false;
			_isSeparatorIndexListChanged = false;
		}
		
		override mx_internal function createTextField(childIndex:int):void
		{
			super.createTextField(childIndex);
			
			if (this.textField) {
//				textField.addEventListener(
//					MouseEvent.DOUBLE_CLICK, textField_doubleClickHandler);
//				textField.addEventListener(
//					KeyboardEvent.KEY_DOWN, textField_keyDownHandler);
//				textField.addEventListener(
//					MouseEvent.CLICK, textField_clickHandler);
			}
		}
		
		override public function get stringValue():String
		{
			return HsStringUtil.removeCharacter(this.text, separator);
		}
		
//		protected function textField_doubleClickHandler(event:MouseEvent):void
//		{
//			trace ("double click");
//		}
//		
//		protected function textField_keyDownHandler(event:KeyboardEvent):void
//		{
//			trace ("key down");
//		}
//		
//		protected function textField_clickHandler(event:MouseEvent):void
//		{
//			trace ("click" + " selection " + textField.selectionBeginIndex + "  " + textField.selectionEndIndex);
//		}
		
	}
}
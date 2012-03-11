package org.hamster.common.components
{
	import flash.events.MouseEvent;
	import flash.events.UncaughtErrorEvent;
	
	import mx.containers.HBox;
	import mx.containers.TitleWindow;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.TextArea;
	import mx.core.LayoutDirection;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	public class FlexErrorPopUpWindowMX extends TitleWindow
	{
		private var _errorIDLbl:Label;
		private var _errorTitleLbl:Label;
		private var _showHideDetailsLbl:Label;
		private var _errorContentTxt:TextArea;
		private var _buttonContentHBox:HBox;
		private var _okButton:Button;
		
		private var _errorID:String;
		private var _errorTitle:String;
		private var _errorContent:String;
		private var _preventSystemAlert:Boolean;
		
		private var _application:UIComponent;
		
		public function set errorID(value:String):void
		{
			_errorID = value;
			if (_errorIDLbl) {
				_errorIDLbl.text = 'Error ID :  ' + value;
			}
		}
		
		public function get errorID():String
		{
			return _errorID;
		}
		
		public function set errorTitle(value:String):void
		{
			_errorTitle = value;
			if (_errorTitleLbl) {
				_errorTitleLbl.text = 'Error Title :  ' + value;
			}
		}
		
		public function get errorTitle():String
		{
			return _errorTitle;
		}
		
		public function set errorContent(value:String):void
		{
			_errorContent = value;
			if (_errorContentTxt) {
				_errorContentTxt.text = value;
			}
			_errorContentTxt.visible = false;
			_errorContentTxt.includeInLayout = false;
			
			if (_errorContent && _errorContent != '') {
				_showHideDetailsLbl.text = 'Show Details';
				_showHideDetailsLbl.setStyle('color', 0x003366);
			} else {
				_showHideDetailsLbl.text = 'No Details';
				_showHideDetailsLbl.setStyle('color', 0x7F7F7F);
			}
		}
		
		public function get errorContent():String
		{
			return _errorContent;
		}
		
		public function set preventSystemAlert(value:Boolean):void
		{
			_preventSystemAlert = value;
		}
		
		public function get preventSystemAlert():Boolean
		{
			return _preventSystemAlert;
		}
		
		public function FlexErrorPopUpWindowMX()
		{
			super();
			
			this.layoutDirection = LayoutDirection.LTR;
			this.width = 600;
			this.maxHeight = 400;
			this.title = 'Oops... a Flex error occured';
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			this.setStyle('paddingBottom', 	5);
			this.setStyle('paddingTop', 	5);
			this.setStyle('paddingLeft', 	10);
			this.setStyle('paddingRight', 	10);
			
			_errorIDLbl = new Label();
			_errorIDLbl.setStyle('fontWeight', 'bold');
			_errorIDLbl.setStyle('fontSize', 12);
			_errorIDLbl.text = errorID;
			_errorIDLbl.percentWidth = 100;
			this.addChild(_errorIDLbl);
			
			_errorTitleLbl = new Label();
			_errorTitleLbl.setStyle('fontWeight', 'bold');
			_errorTitleLbl.setStyle('fontSize', 12);
			_errorTitleLbl.text = errorTitle;
			_errorTitleLbl.percentWidth = 100;
			this.addChild(_errorTitleLbl);
			
			_showHideDetailsLbl = new Label();
			_showHideDetailsLbl.buttonMode = true;
			_showHideDetailsLbl.mouseChildren = false;
			_showHideDetailsLbl.text = 'Show Details';
			_showHideDetailsLbl.setStyle('textDecoration', 'underline');
			_showHideDetailsLbl.setStyle('color', 0x003366);
			_showHideDetailsLbl.addEventListener(MouseEvent.CLICK, showHideDetailsLblClickHandler);
			this.addChild(_showHideDetailsLbl);
			
			_errorContentTxt = new TextArea();
			_errorContentTxt.selectable = true;
			_errorContentTxt.editable = false;
			_errorContentTxt.percentWidth = 100;
			_errorContentTxt.percentHeight = 100;
			_errorContentTxt.visible = false;
			_errorContentTxt.includeInLayout = false;
			this.addChild(_errorContentTxt);
			
			_okButton = new Button();
			_okButton.label = 'OK';
			_okButton.addEventListener(MouseEvent.CLICK, okButtonClickHandler);
			
			_buttonContentHBox = new HBox();
			_buttonContentHBox.setStyle('horizontalAlign', 'center');
			_buttonContentHBox.percentWidth = 100;
			_buttonContentHBox.addElement(_okButton);
			
			this.addChild(_buttonContentHBox);
		}
		
		private function showHideDetailsLblClickHandler(event:MouseEvent):void
		{
			if (errorContent != null && errorContent != '') {
				if (this._errorContentTxt.visible) {
					_errorContentTxt.visible = false;
					_errorContentTxt.includeInLayout = false;
					_showHideDetailsLbl.text = 'Show Details';
				} else {
					_errorContentTxt.visible = true;
					_errorContentTxt.includeInLayout = true;
					_showHideDetailsLbl.text = 'Hide Details';
				}
				PopUpManager.centerPopUp(this);
			}
		}
		
		private function okButtonClickHandler(event:MouseEvent):void
		{
			PopUpManager.removePopUp(this);
		}
		
		public function register(application:UIComponent, preventSystemAlert:Boolean = false):void
		{
			this.preventSystemAlert = preventSystemAlert;
			_application = application;
			application.systemManager.loaderInfo.uncaughtErrorEvents.addEventListener(
				UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
		}
		
		private function uncaughtErrorHandler(event:UncaughtErrorEvent):void
		{
			PopUpManager.addPopUp(this, _application, true);
			PopUpManager.centerPopUp(this);
			
			var error:Error = event.error;
			if (error) {
				this.errorID = error.errorID.toString();
				this.errorTitle = error.message;
				this.errorContent = error.getStackTrace();
			}
			
			if (preventSystemAlert) {
				event.preventDefault();
			}
		}
		
	}
}
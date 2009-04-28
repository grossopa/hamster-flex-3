
import flash.display.DisplayObject;
import flash.external.ExternalInterface;

import mx.collections.ArrayCollection;
import mx.core.Application;
import mx.managers.PopUpManager;

import org.hamster.log.Logger;
import org.hamster.log.LoggerModel;
import org.hamster.log.LoggerPanel;

	
/**
 * @author jack yin grossopforever@gmail.com
 */
	 

public static const TRACE_MODE:uint = 0x001;
public static const PANEL_MODE:uint = 0x010;
public static const HTML_MODE:uint = 0x100;

private const TRACE_COLOR:String = "#3F4FFF";
private const DEBUG_COLOR:String = "#000000";
private const INFO_COLOR:String = "#488074";
private const WARNING_COLOR:String = "#AF972B";
private const ERROR_COLOR:String = "#F6872D";
private const FATAL_COLOR:String = "#FF0000";

[Bindable] public var levelValue:int = 0;

private static var instance:LoggerPanel = new LoggerPanel();
private var _enableLog:Boolean;

private var _enabledTraceMode:Boolean;
private var _enabledPanelMode:Boolean;
private var _enabledHTMLMode:Boolean;

public function set enabledTraceMode(value:Boolean):void
{
	_enabledTraceMode = value;
}

public function get enabledTraceMode():Boolean
{
	return this._enabledTraceMode;
}

public function set enabledPanelMode(value:Boolean):void
{
	_enabledPanelMode = value;
	if(_enabledPanelMode) {
		var app:DisplayObject = DisplayObject(Application.application);
		PopUpManager.addPopUp(instance, app);
		instance.width = app.width * 0.5;
		instance.height = app.height * 0.5;
	} else {
		PopUpManager.removePopUp(instance);		
	}
}

public function get enabledPanelMode():Boolean
{
	return this._enabledPanelMode;
}

public function set enabledHTMLMode(value:Boolean):void
{
	_enabledHTMLMode = value;
	if(_enabledHTMLMode) {
		ExternalInterface.call("eval", 
		"function createLoggerPanelTextArea() {" + 
			"var textarea = document.createElement('textarea');" + 
			"textarea.setAttribute('style', 'width:100%;height:500');" + 
			"textarea.setAttribute('id', 'logForFlash');" + 
			"document.body.appendChild(textarea);" + 
		"}");
		ExternalInterface.call("eval", 
		"function addLogToTextArea(logText) {" + 
			"document.getElementById('logForFlash').value += logText;" + 
		"}");
		ExternalInterface.call("createLoggerPanelTextArea");
	}
}

public function get enabledHTMLMode():Boolean
{
	return this._enabledHTMLMode;
}

[Bindable] private var logDatas:ArrayCollection = new ArrayCollection();

public static function getInstance():LoggerPanel
{
	return instance;
}

public function setLogMode(modes:uint):void
{
	enabledTraceMode = (TRACE_MODE & modes) != 0;
	enabledPanelMode = (PANEL_MODE & modes) != 0;
	enabledHTMLMode  = (HTML_MODE  & modes) != 0;
}
		
public function get enableLog():Boolean
{
	return _enableLog;	
}

private function creationCompleteHandler():void
{
	widthStepper.value = instance.width;
	heightStepper.value = instance.height;
}

public function addLog(logger:Logger, 
		loggerModel:LoggerModel, level:String):void
{
	var color:String;
	var curLevelValue:int = 7;
	
	switch(level) {
		case Logger.TRACE:
			color = TRACE_COLOR;
			curLevelValue = 1;
			break;
		case Logger.DEBUG:
			color = DEBUG_COLOR;
			curLevelValue = 2;
			break;
		case Logger.INFO:
			color = INFO_COLOR;
			curLevelValue = 3;
			break;
		case Logger.WARN:
			color = WARNING_COLOR;
			curLevelValue = 4;
			break;
		case Logger.ERROR:
			color = ERROR_COLOR;
			curLevelValue = 5;
			break;
		case Logger.FATAL:
			color = FATAL_COLOR;
			curLevelValue = 6;
			break;
	}
	loggerModel.color = color;
	if(curLevelValue < levelValue) return;
	
	var resultString:String = loggerModel.toFormatString();
	if(this.enabledPanelMode) {
		mainTextArea.htmlText += "<font color=\"" + color + "\">"
				+ resultString + "</font><br />";
	}
	
	if(this.enabledTraceMode) trace(resultString);
	if(this.enabledHTMLMode) {
		ExternalInterface.call("addLogToTextArea", resultString + "\\n");
	}
	logDatas.addItem(loggerModel);
	if(this.enabledPanelMode) {
		mainTextArea.verticalScrollPosition 
				= mainTextArea.maxVerticalScrollPosition + 1;
	}
}

private function clearHandler():void
{
	mainTextArea.htmlText = "";
	logDatas.removeAll();
}

private function showHideHandler():void
{
	if(showHideButton.label == "show") {
		var app:DisplayObject = DisplayObject(Application.application);
		instance.width = widthStepper.value;
		instance.height = heightStepper.value;
		showHideButton.label = "hide";
	} else if(showHideButton.label == "hide"){
		instance.width = 75;
		instance.height = 62;
		showHideButton.label = "show";
	}
}

private function changeWidthHandler():void
{
	this.width = widthStepper.value;
}

private function changeHeightHandler():void
{
	this.height = heightStepper.value;
}

private function changeLevelHandler(val:Number):String
{
	levelValue = int(val);
	switch(levelValue) {
		case 1:
			return "ALL";
		case 2:
			return Logger.DEBUG;
		case 3:
			return Logger.INFO;
		case 4:
			return Logger.WARN;
		case 5:
			return Logger.ERROR;
		case 6:
			return Logger.FATAL;
	}
	return "ALL";
}
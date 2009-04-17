
import flash.display.DisplayObject;

import org.hamster.log.Logger;
import org.hamster.log.LoggerModel;
import org.hamster.log.LoggerPanel;

import mx.collections.ArrayCollection;
import mx.core.Application;
import mx.managers.PopUpManager;

private const TRACE_COLOR:String = "#3F4FFF";
private const DEBUG_COLOR:String = "#000000";
private const INFO_COLOR:String = "#488074";
private const WARNING_COLOR:String = "#AF972B";
private const ERROR_COLOR:String = "#F6872D";
private const FATAL_COLOR:String = "#FF0000";

private static var instance:LoggerPanel = new LoggerPanel();
private var _enableLog:Boolean;

[Bindable] private var logDatas:ArrayCollection = new ArrayCollection();

public static function getInstance():LoggerPanel
{
	return instance;
}

public function set enableLog(value:Boolean):void
{
	if(value) {
		var app:DisplayObject = DisplayObject(Application.application);
		PopUpManager.addPopUp(instance, app);
		instance.width = app.width * 0.5;
		instance.height = app.height * 0.5;
	} else if(_enableLog){
		PopUpManager.removePopUp(instance);	
	}
	_enableLog = value;
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

public function addLog(logger:Logger, loggerModel:LoggerModel, level:String):void
{
	var color:String;
	var levelValue:int = 7;
	
	switch(level) {
		case Logger.TRACE:
			color = TRACE_COLOR;
			levelValue = 1;
			break;
		case Logger.DEBUG:
			color = DEBUG_COLOR;
			levelValue = 2;
			break;
		case Logger.INFO:
			color = INFO_COLOR;
			levelValue = 3;
			break;
		case Logger.WARN:
			color = WARNING_COLOR;
			levelValue = 4;
			break;
		case Logger.ERROR:
			color = ERROR_COLOR;
			levelValue = 5;
			break;
		case Logger.FATAL:
			color = FATAL_COLOR;
			levelValue = 6;
			break;
	}
	loggerModel.color = color;
	if(levelValue < levelHSlider.value) return;
	
	var resultString:String = loggerModel.toFormatString();
	mainTextArea.htmlText += "<font color=\"" + color + "\">"
			+ resultString + "</font><br />";
	trace(resultString);
	logDatas.addItem(loggerModel);
	mainTextArea.verticalScrollPosition 
			= mainTextArea.maxVerticalScrollPosition + 1;
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
	switch(int(val)) {
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
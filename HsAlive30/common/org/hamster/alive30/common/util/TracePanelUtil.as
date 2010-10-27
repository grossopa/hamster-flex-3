package org.hamster.alive30.common.util
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.logging.ILogger;
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	
	public class TracePanelUtil implements ILoggingTarget
	{
		private var displayed:Boolean;
		private var inited:Boolean;
		private var content:TracePanel;
		private var stage:Stage;
		private var ci:ContextMenuItem;
		
		private static var _instance:TracePanelUtil;
		
		public static function get instance():TracePanelUtil
		{
			if (!_instance) {
				_instance = new TracePanelUtil();
			}
			return _instance;
		}
		
		public function TracePanelUtil()
		{
		}
		
		public function init(swf:Stage, context:InteractiveObject):void
		{
			if(inited) return;
			inited = true;
			stage = swf;
                        
			content = new TracePanel();
			var cm :ContextMenu = context.contextMenu;
			cm.hideBuiltInItems();
			ci = new ContextMenuItem("Show Log", true);
			ci.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onSelect, false, 0, true);
			cm.customItems.push(ci);
			
			Log.addTarget(this);
		}
		
		private function onSelect(e:ContextMenuEvent) : void {
			if(!displayed) {
				show();
			} else {
				hide();
			}
		}

		private function show():void {
			ci.caption = "Hide Log";
			displayed = true;
			stage.addChild(content);
		}

		private function hide():void {
			ci.caption = "Show Log";
			displayed = false;
			stage.removeChild(content);
		}
                
		
		/**
		 * parameter is same as com.common.logging.Logger.log
		 *  
		 * @param level
		 * @param msg
		 * @param rest
		 * 
		 */
		public function logHandler(evt:LogEvent):void
		{
			if (!content) return;
			content.log(evt.level, evt.message);
		}
		
		private var _logger:ILogger;
		private var _level:uint = LogEventLevel.ALL;
		
		public function get filters():Array
		{
			return ["hs.*"];
		}
		
		public function set filters(value:Array):void
		{
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set level(value:int):void
		{
			_level = value;
		}
		
		public function addLogger(logger:ILogger):void
		{
			_logger = logger;
			_logger.addEventListener(LogEvent.LOG, logHandler);
		}
		
		public function removeLogger(logger:ILogger):void
		{
			_logger = null;
			_logger.removeEventListener(LogEvent.LOG, logHandler);
		}

	}
}

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;

import mx.formatters.DateFormatter;
import mx.logging.LogEvent;
import mx.logging.LogEventLevel;

import org.hamster.alive30.common.util.TraceHelper;

class TracePanel extends Sprite 
{
	private var _textField:TextField;
	private static var dateFormat:DateFormatter = new DateFormatter();
	
	public function TracePanel() {
		super();
		dateFormat.formatString = "JJ:NN:SS.";
		
		this.mouseChildren = false;
		this.mouseEnabled = false;
		
		this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
		
		var tf:TextFormat = new TextFormat("Arial", 12, 0xEAEAEA);
		// var tf:TextFormat = new TextFormat("Courier New", 12, 0xEAEAEA);
		_textField = new TextField();
		_textField.defaultTextFormat = tf;
		_textField.wordWrap = true;
		_textField.alpha = 0.8;
		this.addChild(_textField);
		
		draw();
		
	}
	
	private function addedHandler(evt:Event):void
	{
		resize();
		stage.addEventListener(Event.RESIZE, resizeHandler);
	}
	
	private function removedHandler(evt:Event):void
	{
		stage.removeEventListener(Event.RESIZE, resizeHandler);
	}
	
	private function resizeHandler(evt:Event):void
	{
		resize();
	}
	
	private function resize():void
	{
		if (!stage) return;
		_textField.x = 0;
		_textField.y = stage.stageHeight >> 1;
		_textField.width = stage.stageWidth;
		_textField.height = stage.stageHeight >> 1;
		_textField.scrollV = _textField.maxScrollV;
		draw();
	}
	
	private function draw():void
	{
		if (!stage) return;
		var g:Graphics = this.graphics;
		g.clear();
		g.beginFill(0x000000, 0.6);
		g.drawRect(0, stage.stageHeight >> 1, stage.stageWidth, stage.stageHeight >> 1);
		g.endFill();
		
	}
	
	public function log(level:int, msg:String, ...rest):void
	{
		var date:Date = new Date();
		_textField.appendText(dateFormat.format(date));
		var m:Number = date.milliseconds;
		if (m < 10) _textField.appendText("00");
		else if (m < 100) _textField.appendText("0");
		_textField.appendText(m.toString());
		_textField.appendText(levToStr(level));
		_textField.appendText(TraceHelper.curLine() + "  ");
		_textField.appendText(msg);
		_textField.appendText('\n');
		if (_textField.length > 10000) {
			_textField.replaceText(0, 5000, "");
		}
		_textField.scrollV = _textField.maxScrollV;
		
	}
	
	public static function levToStr(level:int):String
	{
		switch (level) {
			case LogEventLevel.DEBUG:
				return " [DEBUG] ";
			case LogEventLevel.INFO:
				return " [INFO ] ";
			case LogEventLevel.WARN:
				return " [WARN ] ";
			case LogEventLevel.ERROR:
				return " [ERROR] ";
			case LogEventLevel.FATAL:
				return " [FATAL] ";
			case LogEventLevel.ALL:
				return " [ALL  ] ";
			default:
				return " [TRACE] "
		}
	}
}
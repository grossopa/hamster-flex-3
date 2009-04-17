package org.hamster.log
{
	import org.hamster.debug.Assert;
	
	import mx.formatters.DateFormatter;
	
	final public class Logger
	{
		public static const TRACE:String = "TRACE";
		public static const DEBUG:String = "DEBUG";
		public static const INFO:String = "INFO";
		public static const WARN:String = "WARN";
		public static const ERROR:String = "ERROR";
		public static const FATAL:String = "FATAL";
		
		public static const SEQ_TIME:int = 0;
		public static const SEQ_LEVEL:int = 1;
		public static const SEQ_STR:int = 2;
		public static const SEQ_CLASS:int = 3;
		
		private static const DEF_DATE_FORMAT_STR:String = "J:NN:SS";
		
		private static var sequence:Array;
		private static var panel:LoggerPanel = LoggerPanel.getInstance();
		
		private var _className:String;
		
		public var dateFormatter:DateFormatter;
		
		public function setSequence(...arg):void
		{
			sequence = arg;
		}
		
		public function get className():String
		{
			return this._className;
		}
		
		public function Logger(className:String)
		{
			this._className = className;
			if(dateFormatter == null) {
				dateFormatter = new DateFormatter();
				dateFormatter.formatString = DEF_DATE_FORMAT_STR;
			}
			
			if(sequence == null) {
				setSequence(SEQ_TIME, SEQ_LEVEL, SEQ_CLASS, SEQ_STR);
			}
		}
		
		public static function getLogger(className:String):Logger
		{
			return new Logger(className);
		}
		
		public function traceValue(str:String, func:String = ""):void
		{
			panel.addLog(this, initStr(str, TRACE, func), TRACE);
		}

		public function debug(str:String, func:String = ""):void
		{
			panel.addLog(this, initStr(str, DEBUG, func), DEBUG);
		}
		
		public function info(str:String, func:String = ""):void
		{
			panel.addLog(this, initStr(str, INFO, func), INFO);
		}
		
		public function warning(str:String, func:String = ""):void
		{
			panel.addLog(this, initStr(str, WARN, func), WARN);
		}
		
		public function error(str:String, func:String = ""):void
		{
			panel.addLog(this, initStr(str, ERROR, func), ERROR);
		}
		
		public function fatal(str:String, func:String = ""):void
		{
			panel.addLog(this, initStr(str, FATAL, func), FATAL);
		}
		
		private function initStr(
				mainStr:String, level:String, func:String):LoggerModel
		{
			if(sequence == null) {
				setSequence(SEQ_TIME, SEQ_LEVEL, SEQ_CLASS, SEQ_STR);
			}
			
			LoggerModel.sequence = sequence;
			
			var result:LoggerModel = new LoggerModel();
			var date:Date = new Date();
			if(dateFormatter == null) {
				dateFormatter = new DateFormatter();
				dateFormatter.formatString = DEF_DATE_FORMAT_STR;
			}
			result.time	= dateFormatter.format(date);
			result.level = level;
			result.className = this._className;
			if (func != null && func.length != 0) {
				result.className += "." + func;
			}
			result.mainString = mainStr;
			return result;
		}

	}
}
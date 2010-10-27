package org.hamster.alive30.game.control
{
	import flash.system.System;
	import flash.utils.Timer;

	public class RealTimeManager
	{
		private static var _instance:RealTimeManager;
		public static function get instance():RealTimeManager
		{
			if (!_instance) {
				_instance = new RealTimeManager();
			}
			return _instance;
		}
		
		private const records:Array = new Array();
		
		public function RealTimeManager()
		{
		}
		
		public function addRecord(name:String):void
		{
			if (records.indexOf(name) < 0) {
				records.push({"name" : name, "time" : new Date().time});
			}
		}
		
		public function getTimeElapsed(name:String):Number
		{
			var objIndex:int = -1;
			for (var i:int = 0, len:int = records.length; i < len; i++) {
				if (records[i].name == name) {
					objIndex = i;
					break;
				}
			}
			if (objIndex == -1) {
				return -1;
			} else {
				var currentTime:Number = new Date().time;
				var oldTime:Number = records[objIndex].time;
				records[objIndex].time = currentTime;
				return currentTime - oldTime;
			}
		}
	}
}
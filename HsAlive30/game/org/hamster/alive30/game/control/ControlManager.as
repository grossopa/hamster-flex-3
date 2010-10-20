package org.hamster.alive30.game.control
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.core.IUIComponent;

	public class ControlManager
	{
		private static var _instance:ControlManager;
		
		public static function get instance():ControlManager
		{
			if (!_instance) {
				_instance = new ControlManager();
			}
			return _instance;
		}
		
		public var stage:Stage;
		
		public function ControlManager()
		{
		}
		
		public function addListener(keyDownHandler:Function, keyUpHandler:Function):void
		{
			if (keyDownHandler != null) {
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			}
			
			if (keyUpHandler != null) {
				stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			}
		}
		
		public function removeListener(keyDownHandler:Function, keyUpHandler:Function):void
		{
			if (keyDownHandler != null) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			}
			
			if (keyUpHandler != null) {
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			}
		}
		
	}
}
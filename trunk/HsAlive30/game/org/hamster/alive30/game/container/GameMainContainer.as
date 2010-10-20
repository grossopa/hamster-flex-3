package org.hamster.alive30.game.container
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.hamster.alive30.common.component.SimpleContainer;
	import org.hamster.alive30.common.util.IVector2DItem;
	import org.hamster.alive30.game.control.ControlManager;
	import org.hamster.alive30.game.item.DangerCircle;
	import org.hamster.alive30.game.item.Plane;
	
	public class GameMainContainer extends UIComponent
	{
		private static const logger:ILogger = Log.getLogger('hs.GameMainContainer');
		private static var ctrlManager:ControlManager = ControlManager.instance;
		
		private var _mainContainer:SimpleContainer;
		
		private var _plane:Plane;
		
		public function GameMainContainer()
		{
			super();
			_mainContainer = new SimpleContainer();
			_mainContainer.measuredWidth = 800;
			_mainContainer.measuredHeight = 600;
			_mainContainer.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_plane = new Plane();
			_mainContainer.addChild(_plane);
			
			var dc:DangerCircle = new DangerCircle();
			dc.x = 200;
			dc.y = 100;
			_mainContainer.addChild(dc);
			
			this.addChild(_mainContainer);
			
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		private function registerListener():void
		{
			ctrlManager.addListener(_keyDownHandler, _keyUpHandler);
		}
		
		private function creationCompleteHandler(evt:FlexEvent):void
		{
			this.callLater(registerListener);
		}
		
		private function enterFrameHandler(evt:Event):void
		{
			for (var i:int = 0, len:int = _mainContainer.numChildren; i < len; i++) {
				var child:Sprite = this._mainContainer.getChildAt(i) as Sprite;
				if (child is IVector2DItem) {
					var vc:IVector2DItem = IVector2DItem(child);
					child.x += vc.speedVector.x;
					child.y += vc.speedVector.y;
					vc.speedVector.x += vc.accelVector.x;
					vc.speedVector.y += vc.accelVector.y;
				}
			}
		}
		
		private function _keyDownHandler(evt:KeyboardEvent):void
		{
			//logger.info("Key Down : " + evt.keyCode);
			if (evt.keyCode == Keyboard.LEFT) {
				_plane.speedVector.x = -3;
			} else if (evt.keyCode == Keyboard.RIGHT) {
				_plane.speedVector.x = 3;
			} else if (evt.keyCode == Keyboard.UP) {
				_plane.speedVector.y = -3;
			} else if (evt.keyCode == Keyboard.DOWN) {
				_plane.speedVector.y = 3;
			}
		}
		
		private function _keyUpHandler(evt:KeyboardEvent):void
		{
			//logger.info("Key Up   : " + evt.keyCode);
			if (evt.keyCode == Keyboard.LEFT || evt.keyCode == Keyboard.RIGHT) {
				_plane.speedVector.x = 0;
			} else if (evt.keyCode == Keyboard.UP || evt.keyCode == Keyboard.DOWN) {
				_plane.speedVector.y = 0;
			}
		}
	}
}
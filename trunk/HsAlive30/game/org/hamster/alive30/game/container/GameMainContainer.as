package org.hamster.alive30.game.container
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.hamster.alive30.common.component.SimpleContainer;
	import org.hamster.alive30.common.manager.CacheManager;
	import org.hamster.alive30.common.util.IVector2DItem;
	import org.hamster.alive30.game.control.ControlManager;
	import org.hamster.alive30.game.control.RealTimeManager;
	import org.hamster.alive30.game.event.GameEvent;
	import org.hamster.alive30.game.item.Bullet;
	import org.hamster.alive30.game.item.Plane;
	import org.hamster.alive30.game.model.vo.BulletListVO;
	import org.hamster.alive30.game.model.vo.BulletVO;
	import org.hamster.alive30.game.util.GameConstants;
	import org.hamster.alive30.game.util.GameUtil;
	
	[Event(name="planeHit", type="org.hamster.alive.game.event.GameEvent")]
	
	public class GameMainContainer extends UIComponent
	{
		public static const NAME:String = "GameMainContainer";
		private static const logger:ILogger = Log.getLogger('hs.GameMainContainer');
		private static var ctrlManager:ControlManager = ControlManager.instance;
		private static var cacheManager:CacheManager = CacheManager.instance;
		private static var timeManager:RealTimeManager = RealTimeManager.instance;
		
		private var _mainContainer:SimpleContainer;
		
		private var _plane:Plane;
		private var _bullets:ArrayCollection = new ArrayCollection();
		private var _nextBulletVOList:BulletListVO;
		
		private var _bulletListVOArray:Array;
		
		public function set bulletListVOArray(value:Array):void { _bulletListVOArray = value }
		public function get bulletListVOArray():Array { return _bulletListVOArray }
		
		public function GameMainContainer()
		{
			super();
			_mainContainer = new SimpleContainer();
			_mainContainer.measuredWidth = 800;
			_mainContainer.measuredHeight = 600;
			_mainContainer.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_plane = new Plane();
			_plane.type = GameConstants.BLUE;
			_mainContainer.addChild(_plane);
			
			for (var i:int = 0; i < 100; i++) {
				var dc:Bullet = new Bullet();
				dc.x = 200 * Math.random();
				dc.y = 200 * Math.random();
				dc.type = GameConstants.BLUE;
				_mainContainer.addChild(dc);
				_bullets.addItem(dc);
			}
			
			timeManager.addRecord(NAME);
			
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
			var timeElasped:Number = timeManager.getTimeElapsed(NAME);
			
			// handle nextBulletVOs
			updateBulletVOList(timeElasped);
			
			// update vectors
			updateAbsorbedBullets();
			
			for (var i:int = 0, len:int = _mainContainer.numChildren; i < len; i++) {
				var child:Sprite = this._mainContainer.getChildAt(i) as Sprite;
				if (child is IVector2DItem) {
					var vc:IVector2DItem = IVector2DItem(child);
					child.x += vc.speedVector.x;
					child.y += vc.speedVector.y;
					vc.speedVector.x += vc.accelVector.x;
					vc.speedVector.y += vc.accelVector.y;
					vc.onEnterFrameHandler(timeElasped);
				}
			}
			
			var hitResult:Array = planeHitTest();
			absorbBullet(hitResult);
			hitByBullet(hitResult);
		}
		
		private function _keyDownHandler(evt:KeyboardEvent):void
		{
			if (evt.keyCode == Keyboard.LEFT) {
				_plane.speedVector.x = - GameConstants.MOVE_SPEED;
			} else if (evt.keyCode == Keyboard.RIGHT) {
				_plane.speedVector.x = GameConstants.MOVE_SPEED;
			} else if (evt.keyCode == Keyboard.UP) {
				_plane.speedVector.y = -GameConstants.MOVE_SPEED;
			} else if (evt.keyCode == Keyboard.DOWN) {
				_plane.speedVector.y = GameConstants.MOVE_SPEED;
			} else if (evt.keyCode == Keyboard.CONTROL) {
				if (_plane.type == GameConstants.RED) {
					_plane.type = GameConstants.BLUE;
				} else {
					_plane.type = GameConstants.RED;
				}
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
		
		private function planeHitTest():Array
		{
			var result:Array = [];
			for each (var bullet:Bullet in _bullets) {
				var testResult:Boolean;
				if (bullet.type != this._plane.type) {
					testResult = GameUtil.hitTest(_plane, bullet, 
						GameConstants.PLANE_DIFF_TYPE_HIT_RADIUS, 
						GameConstants.PLANE_DIFF_TYPE_HIT_RADIUS,
						GameConstants.BULLET_HIT_RADIUS,
						GameConstants.BULLET_HIT_RADIUS);
				} else {
					testResult = GameUtil.hitTest(_plane, bullet, 
						GameConstants.PLANE_SAME_TYPE_HIT_RADIUS, 
						GameConstants.PLANE_SAME_TYPE_HIT_RADIUS,
						GameConstants.BULLET_HIT_RADIUS,
						GameConstants.BULLET_HIT_RADIUS);
				}
				if (testResult) {
					result.push(bullet);
				}
			}
			return result;
		}
		
		private function updateBulletVOList(timeElasped:Number):void
		{
			if (!_nextBulletVOList && _bulletListVOArray.length > 0) {
				_nextBulletVOList = _bulletListVOArray.pop();
			} else if (!_nextBulletVOList) {
				return;
			}
			
			_nextBulletVOList.timeGap -= timeElasped;
			if (_nextBulletVOList.timeGap <= 0) {
				var bulletVOList:Array = _nextBulletVOList.bulletVOList;
				for each (var bulletVO:BulletVO in bulletVOList) {
					var bullet:Bullet = this.getBulletFromCache();
					bullet.applyVO(bulletVO);
					this._bullets.addItem(bullet);
					this._mainContainer.addChild(bullet);
				}
				_nextBulletVOList = null;
			}
		}
		
		private function updateAbsorbedBullets():void
		{
			var planeCX:Number = _plane.x + GameConstants.PLANE_SAME_TYPE_HIT_RADIUS;
			var planeCY:Number = _plane.y + GameConstants.PLANE_SAME_TYPE_HIT_RADIUS;
			var removeChildren:Array = new Array();
			for each (var bullet:Bullet in _bullets) {
				var distance:Number = 
					(bullet.x + (bullet.width >> 1) - planeCX) 
					* (bullet.x + (bullet.width >> 1) - planeCX) 
					+ (bullet.y + (bullet.width >> 1) - planeCY)
					* (bullet.y + (bullet.width >> 1) - planeCY);
				if (bullet.isAbsorbed && distance >= 5) {
					var percent:Number = Math.sqrt(distance) / (GameConstants.BULLET_HIT_RADIUS + GameConstants.PLANE_SAME_TYPE_HIT_RADIUS);
					if (percent > 1) {
						percent = 1;
					}
					bullet.scaleX = percent;
					bullet.scaleY = percent;
					bullet.speedVector.x = planeCX - (bullet.x + GameConstants.BULLET_HIT_RADIUS * percent);
					bullet.speedVector.y = planeCY - (bullet.y + GameConstants.BULLET_HIT_RADIUS * percent);
					bullet.speedVector.length = GameConstants.ABSORB_SPEED;
				} else if (distance < 5) {
					bullet.speedVector.x = 0;
					bullet.speedVector.y = 0;
					removeChildren.push(bullet);
				}
			}
			
			for each (var rb:Bullet in removeChildren) {
				//_bullets.splice((_bullets.indexOf(rb), 1);
				_bullets.removeItemAt(_bullets.getItemIndex(rb));
				this._mainContainer.removeChild(rb);
			}
		}
		
		private function absorbBullet(array:Array):void
		{
			for each (var bullet:Bullet in array) {
				if (bullet.type == this._plane.type) {
					bullet.isAbsorbed = true;
				}
			}
		}
		
		private function hitByBullet(array:Array):void
		{
			for each (var bullet:Bullet in array) {
				if (bullet.type != _plane.type && !_plane.isChangingType) {
					logger.info("boom");
					this.dispatchEvent(new GameEvent(GameEvent.PLANE_HIT));
					return;
				}
			}
		}
		
		private function getBulletFromCache():Bullet
		{
			if (!cacheManager.contains("bulletCacheArray", "Bullet")) {
				cacheManager.putItem("bulletCacheArray", [], "Bullet");
			}
			var array:Array = cacheManager.getItem("bulletCacheArray", "Bullet");
			if (array.length > 0) {
				var bullet:Bullet = array.pop();
				return bullet;
			} else {
				var newBullet:Bullet = new Bullet();
				return newBullet;
			}
		}
		
		private function putBulletIntoCache(bullet:Bullet):void
		{
			var array:Array = cacheManager.getItem("bulletCacheArray", "Bullet");
			if (array.indexOf(bullet) == -1) {
				array.push(bullet);
			}
		}
	}
}
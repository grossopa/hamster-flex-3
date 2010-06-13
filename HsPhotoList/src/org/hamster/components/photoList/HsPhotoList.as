package org.hamster.components.photoList
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	
	import mx.containers.Canvas;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.effects.AnimateProperty;
	import mx.effects.easing.Linear;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import spark.components.Group;
	
	
	public class HsPhotoList extends Canvas
	{
		private var _radius:Number = 200;
		private var _minRadius:Number = int.MAX_VALUE;
		private var _maxWidth:Number = 0;
		private var _itemArray:Array = [];
		private const _aniProperties:AnimateProperty = new AnimateProperty(this);
		private var _angleOffset:Number = 0;
		private var _speed:Number = 200;
		private var _isRotationY:Boolean = true;
		
		public function set angleOffset(value:Number):void
		{
			this._angleOffset = value;
			if (this.initialized) {
				this.layoutHandler(angleOffset * Math.PI / 180);
			}
		}
		
		public function get angleOffset():Number
		{
			return this._angleOffset;
		}
		
		public function set isRotationY(value:Boolean):void
		{
			this._isRotationY = value;
			if (this.initialized) {
				this.layoutHandler(this.angleOffset * Math.PI / 180);
			}
		}
		
		public function get isRotationY():Boolean
		{
			return this._isRotationY;
		}
		/**
		 * set slider item.
		 *  
		 * @param itemArray
		 * @param radius
		 * 
		 */
		public function setSliderItem(itemArray:Array, radius:Number):void
		{
			this._itemArray = itemArray;
			this._radius = radius;
			if (this.initialized) {
				this.initItems();
			}
		}
		
		public function set easingFunction(func:Function):void
		{
			this._aniProperties.easingFunction = func;
		}
		
		public function get easingFunction():Function
		{
			return this._aniProperties.easingFunction;
		}
		
		public function set speed(value:Number):void
		{
			this._speed = value;
		}
		
		public function get speed():Number
		{
			return this._speed;
		}
		
		public function HsPhotoList()
		{
			super();
			
			this.addEventListener(ResizeEvent.RESIZE, resizeHandler);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
			
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";
			
			_aniProperties.target = this;
			_aniProperties.property = 'angleOffset';
			_aniProperties.easingFunction = Linear.easeInOut;
		}
		
		private function initItems():void
		{
			refreshTransformCenter();
			this.removeAllChildren();
			
			_minRadius = 0;
			
			if (_itemArray == null || _itemArray.length == 0) {
				return;
			}
			
			_maxWidth = 0;
			
			for each (var uiComponent:UIComponent in _itemArray) {
				_maxWidth = Math.max(uiComponent.width, _maxWidth);
				this.addChild(uiComponent);
			}
			
			this._radius = Math.max(_maxWidth * this._itemArray.length / Math.PI / 2, _radius);
			
			this.layoutHandler(0);
		}
		
		protected function resizeHandler(evt:ResizeEvent):void
		{
			refreshTransformCenter();
		}
		
		protected function refreshTransformCenter():void
		{
			this.transform.perspectiveProjection = new PerspectiveProjection();
			this.transform.perspectiveProjection.projectionCenter 
				= new Point(this.width / 2, 0);	
		}

		
		
		private function completeHandler(evt:FlexEvent):void
		{
			this.initItems();
		}
		
		private function sortItems():void
		{
			var items:Array = this.getChildren();
			items.sort(depthSort);
			for (var i:int = 0; i < this.numChildren; i++) {
				var uiComponent:UIComponent = UIComponent(items[i]);
				if (uiComponent.z > 0) {
					uiComponent.alpha = 0.5 - 0.3 * (uiComponent.z + this._radius) / 2 / this._radius;
				} else {
					uiComponent.alpha = 1;
				}
				this.setChildIndex(items[i], i);
			}
		}
		
		/**
		 * 
		 * @param objA
		 * @param objB
		 * @return 
		 * 
		 */
		private function depthSort(objA:DisplayObject, objB:DisplayObject):int
		{
			var posA:Vector3D = objA.transform.matrix3D.position;
			posA = this.transform.matrix3D.deltaTransformVector(posA);
			var posB:Vector3D = objB.transform.matrix3D.position;
			posB = this.transform.matrix3D.deltaTransformVector(posB);
			return posB.z - posA.z;
		}
		
		/**
		 * 
		 * @param angleOffset
		 * 
		 */
		protected function layoutHandler(angleOffset:Number):void
		{
			var l:int = this.numChildren;
			for (var i:int = 0; i < l; i++) {
				var child:UIComponent = UIComponent(_itemArray[i]);
				var angle:Number = Math.PI * 2 / l * i + angleOffset - 90;
				child.y = child.height;
				child.z = Math.sin(angle) * _radius;
				child.transformX = child.width / 2;
				child.x = Math.cos(angle) * _radius + this.width / 2 - child.width / 2;
				if (this._isRotationY) {
					child.rotationY = -angle / Math.PI * 180 + 90;
				} else {
					child.rotationY = 0;
				}
			}
			this.sortItems();
		}
		
		/////////////////////
		// control methods //
		/////////////////////
		/**
		 * 
		 * @param index
		 * @param counterClockwise
		 * @param times
		 * 
		 */
		public function setFocusItemByIndex(index:int, counterClockwise:Boolean = false, times:int = 1):void
		{
			var curOffset:Number = (this.angleOffset) % 360;
			var toValue:Number = (index + 1) * 360 / this._itemArray.length;
//			if (toValue == 360) {
//				toValue = 0;
//			}
			var byValue:Number = 0;
			
			if (!counterClockwise) {
				if (curOffset < toValue) {
					byValue =  - 360 + toValue - curOffset;
				} else {
					byValue = - toValue + curOffset;
				}
			} else {
				if (curOffset > toValue) {
					byValue = 360 - toValue + curOffset;
				} else {
					byValue = toValue - curOffset;
				}
			}
			
			byValue += (times - 1) * 360;
			
			if (_aniProperties.isPlaying) {
				_aniProperties.stop();
			}
			_aniProperties.toValue = this.angleOffset + byValue;
			_aniProperties.duration = this._speed *  
				Math.abs(int(byValue / (360 / this._itemArray.length)));
			_aniProperties.play();
		}
		
		private function rollOverHandler(evt:MouseEvent):void
		{
			var ui:UIComponent = UIComponent(evt.currentTarget);
			ui.filters = [new DropShadowFilter()];
		}
		
		private function rollOutHandler(evt:MouseEvent):void
		{
			var ui:UIComponent = UIComponent(evt.currentTarget);
			ui.filters = [];
		}
	}
}
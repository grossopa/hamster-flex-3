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
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import spark.components.Group;
	
	
	public class HsPhotoList extends Canvas
	{
		private var _radius:Number = 200;
		private var _itemArray:Array = [];
		
		public function HsPhotoList()
		{
			super();
			
			this.addEventListener(ResizeEvent.RESIZE, resizeHandler);
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
	//		this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			//this.addEventListener(Event.ENTER_FRAME, mouseMoveHandler);
			
//			this.setStyle('backgroundColor', 0x111111);
//			this.setStyle('backgroundAlpha', 0.1);
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
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
			for each (var child:Object in this.getChildren()) {
				_itemArray.push(child);
			}
			
			this.parent.addEventListener(MouseEvent.CLICK, mouseMoveHandler);
			layoutHandler(this.mouseX);
			
			for each (var ui:UIComponent in this.getChildren()) {
				ui.addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
				ui.addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
			}
			
			var timer:Timer = new Timer(15, 0);
			timer.addEventListener(TimerEvent.TIMER, function ():void
			{
				mouseMoveHandler(null);
			});
			timer.start();
			
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
		
		private function mouseMoveHandler(evt:Event):void
		{
			//this.transformY = this.width / 2;
			//this.transformX = this.height / 2;
			//this.rotationX = Math.PI * 2 + mouseX * 0.04;
			//this.rotationY = Math.PI * 2 + mouseX * 20;
			
			layoutHandler(this.mouseX);
			//this.transformX = this.width / 2;
			//this.rotationY += 2;
			this.sortItems(this.mouseX);
			//this.y = (mouseY - this.y) * 0.1;
		}
		
		private function sortItems(offset:int):void
		{
			var items:Array = this.getChildren();
			items.sort(depthSort);
			for (var i:int = 0; i < this.numChildren; i++) {
				this.setChildIndex(items[i], i);
				//this.setChildIndex(items[i], (i + Math.floor(offset / 100)) % this.numChildren);
			}
		}
		
		private function depthSort(objA:DisplayObject, objB:DisplayObject):int
		{
			var posA:Vector3D = objA.transform.matrix3D.position;
			posA = this.transform.matrix3D.deltaTransformVector(posA);
			var posB:Vector3D = objB.transform.matrix3D.position;
			posB = this.transform.matrix3D.deltaTransformVector(posB);
			return posB.z - posA.z;
		}
		
		protected function layoutHandler(offset:int):void
		{
			var l:int = this.numChildren;
			for (var i:int = 0; i < l; i++) {
				var child:UIComponent = UIComponent(_itemArray[i]);
				var angle:Number = Math.PI * 2 / l * i + offset * 0.04;
				child.y = child.height;
				child.z = Math.sin(angle) * _radius;
				child.transformX = child.width / 2;
				child.x = Math.cos(angle) * _radius + this.width / 2 - child.width / 2;
				child.rotationY = -angle /Math.PI * 180 + 90;
			}
	
		}
	}
}
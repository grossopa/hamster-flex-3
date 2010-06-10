package org.hamster.components.photoList
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import mx.containers.Canvas;
	import mx.events.FlexEvent;
	
	
	public class HsPhotoList extends Canvas
	{
		private var _radius:Number = 200;
		
		public function HsPhotoList()
		{
			super();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			this.setStyle('backgroundColor', 0x111111);
			this.setStyle('backgroundAlpha', 0.1);
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";
		}
		
		private function completeHandler(evt:FlexEvent):void
		{
			this.transform.perspectiveProjection = new PerspectiveProjection();
			this.transform.perspectiveProjection.projectionCenter = new Point(this.width / 2, 0);
			layoutHandler(0);
		}
		
		private function mouseMoveHandler(evt:Event):void
		{
			layoutHandler(this.mouseX);
			// this.sortItems();
		}
		
		private function sortItems():void
		{
			var items:Array = this.getChildren();
			items.sort(depthSort);
			for (var i:int = 0; i < this.numChildren; i++) {
				this.setChildIndex(items[i], i);
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
				var child:DisplayObject = this.getChildAt(i);
//				child.transform.perspectiveProjection = new PerspectiveProjection();
//				child.transform.perspectiveProjection.projectionCenter = new Point(child.width, 0);
				var angle:Number = Math.PI * 2 / l * i + offset * 0.04;
				
				//if (Math.cos(angle) > 0) {
					//child.x += child.width / 2;
//				} else {
//					child.x -= child.width / 2;
//				}
				child.y = this.height / 2 - child.height;
				child.z = Math.sin(angle) * _radius;
			//	child.rotationY =  -angle / Math.PI * 180 - 90;
				child.transform.matrix3D.prependRotation(-angle / Math.PI * 180 - 90, 
					new Vector3D(0,1,0), new Vector3D(child.width / 2));
				child.transform.matrix3D.prependTranslation(0, 0,0);
				child.x = Math.cos(angle) * _radius + this.width / 2;
				//child.rotationY = angle  /l * i + 90;
			}
		}
	}
}
package org.hamster.components
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	
	/**
	 * not available yet.
	 * 
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 */
	public class ReflectionHList extends Canvas
	{
		public static const SELECT_FILTER:GlowFilter = new GlowFilter(0x000000, 0.5);
		
		// style definition
		public var gap:Number = 5;
		public var marginLeft:Number = 0;
		public var marginTop:Number = 0;
		public var marginBottom:Number = 0;
		public var reflectionGap:Number = 5;
		
		// functionality definition
		private var _selectable:Boolean;
	//	private var _usePagination:Boolean;
		
		public function set selectable(value:Boolean):void
		{
			this._selectable = value;
			if(_selectable) {
				for each(var refCanvas:ReflectionCanvas in this.getChildren()) {
					refCanvas.buttonMode = true;
				}
			} else {
				for each(refCanvas in this.getChildren()) {
					refCanvas.buttonMode = false;
					refCanvas.filters = [];
				}				
			}
			
		}
		
		public function get selectable():Boolean
		{
			return this._selectable;
		}
		
//		public function set usePagination(value:Boolean):void
//		{
//			this._usePagination = value;
//			if(_usePagination) {
//				
//			} else {
//				
//			}
//		}
		
//		public function get usePagination():Boolean
//		{
//			return this._usePagination;
//		}
		
		public function ReflectionHList()
		{
			super();
		}
		
		/**
		 * @param child origin DisplayObject
		 * return ReflectionCanvas Object
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(createRefCanvas(child));
			refreshRefChild();
			return child;
		}
		
		/**
		 * @param child origin DisplayObject
		 * return ReflectionCanvas Object
		 */
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			for each (var refCanvas:ReflectionCanvas in this.getChildren()) {
				if (refCanvas.mainDisObj == child) {
					super.removeChild(child);
					refreshRefChild();
					return child;
				}
			}
			return null;
		}
		
		private function refreshRefChild():void
		{
			var nextX:Number = 0;
			for each(var refCanvas:ReflectionCanvas in this.getChildren()) {
				refCanvas.x = nextX;
				refCanvas.y = marginTop;
				refCanvas.gap = this.reflectionGap;
				refCanvas.height = this.height - marginTop - marginBottom;
				refCanvas.paintReflection();
				nextX += refCanvas.width + gap;
			}
		}
		
		/**
		 * factory method
		 */
		private function createRefCanvas(disObj:DisplayObject):ReflectionCanvas
		{
			var result:ReflectionCanvas = new ReflectionCanvas();
			result.mainDisObj = disObj;
			result.addEventListener(MouseEvent.CLICK, selectHandler);
			return result;
		}
		
		private function selectHandler(evt:MouseEvent):void
		{
			if(_selectable) {
				var curObj:ReflectionCanvas = ReflectionCanvas(evt.currentTarget);
				for each(var refObj:ReflectionCanvas in this.getChildren()) {
					refObj.filters = [];
				}
				curObj.filters = [SELECT_FILTER];
			}
		}
		
	}
}
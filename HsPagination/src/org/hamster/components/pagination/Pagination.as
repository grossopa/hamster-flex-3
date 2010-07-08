package org.hamster.components.pagination
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.layouts.VerticalLayout;
	import spark.layouts.supportClasses.LayoutBase;
	
	[Event(name="change", type="org.hamster.components.pagination.PaginationEvent")]
	
	public class Pagination extends HGroup
	{
		private var _totalSize:int;
		private var _countPerPaging:int = 10;
		private var _currentIndex:int;
		
		public function set totalSize(value:int):void
		{
			if (this._totalSize != value) {
				this._totalSize = value;
				var disEvt:PaginationEvent = new PaginationEvent(PaginationEvent.CHANGE);
				disEvt.oldIndex = this._currentIndex;
				disEvt.newIndex = this._currentIndex;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get totalSize():int
		{
			return this._totalSize;
		}
		
		public function set countPerPaging(value:int):void
		{
			if (this._countPerPaging != value) {
				this._countPerPaging = value;
				var disEvt:PaginationEvent = new PaginationEvent(PaginationEvent.CHANGE);
				disEvt.oldIndex = this._currentIndex;
				disEvt.newIndex = this._currentIndex;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get countPerPaging():int
		{
			return this._countPerPaging;
		}
		
		public function set currentIndex(value:int):void
		{
			if (this._currentIndex != value) {
				var disEvt:PaginationEvent = new PaginationEvent(PaginationEvent.CHANGE);
				disEvt.oldIndex = this._currentIndex;
				this._currentIndex = value;
				disEvt.newIndex = this._currentIndex;
				this.dispatchEvent(disEvt);
			}
		}
		
		public function get currentIndex():int
		{
			return this._currentIndex;
		}
		
		// getter
		public function get startIndex():int
		{
			return this._currentIndex - (this._currentIndex % this._countPerPaging);
		}
		
		private var _farLeftBtn:Label;
		private var _farRightBtn:Label;
		private var _goLeftBtn:Label;
		private var _goRightBtn:Label;
		
		private var _numberLabelPool:Array = new Array();
		
		public function Pagination()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_farLeftBtn = new Label();
			_farLeftBtn.buttonMode = true;
			_farLeftBtn.addEventListener(MouseEvent.CLICK, farLeftBtnClickHandler);
			_farLeftBtn.text = "<<";
			
			_farRightBtn = new Label();
			_farRightBtn.buttonMode = true;
			_farRightBtn.addEventListener(MouseEvent.CLICK, farRightBtnClickHandler);
			_farRightBtn.text = ">>";
			
			_goLeftBtn = new Label();
			_goLeftBtn.buttonMode = true;
			_goLeftBtn.addEventListener(MouseEvent.CLICK, goLeftBtnClickHandler);
			_goLeftBtn.text = "<";
			
			_goRightBtn = new Label();
			_goRightBtn.buttonMode = true;
			_goRightBtn.addEventListener(MouseEvent.CLICK, goRightBtnClickHandler);
			_goRightBtn.text = ">";
			
			_numberLabelPool = new Array();
			
			for (var i:int = 0; i < this._countPerPaging; i++) {
				var lab:Label = new Label();
				lab.buttonMode = true;
				lab.addEventListener(MouseEvent.CLICK, numLabelClickHandler);
				this._numberLabelPool[i] = lab;
			}
			
			refreshLabelItems();
			
			this.addEventListener(PaginationEvent.CHANGE, indexChangedHandler);
		}
		
		private function refreshLabelItems():void
		{
			this.removeAllElements();
			
			var curPage:int = int(this._currentIndex / this._countPerPaging);
			var maxPage:int = int(this._totalSize / this._countPerPaging);
			
			this.addElement(_farLeftBtn);
			_farLeftBtn.visible = curPage > 0;
			this.addElement(_goLeftBtn);
			_goLeftBtn.visible = this._currentIndex > 0;
			
			var stIndex:int = this.startIndex;
			for (var i:int = 0; i < this._countPerPaging; i++) {
				if (i + stIndex >= this._totalSize) {
					break;
				}
				
				var lab:Label = this._numberLabelPool[i]
				if (i != this._currentIndex - stIndex) {
					lab.text = (i + stIndex + 1).toString();
					lab.setStyle("fontWeight", "normal");
				} else {
					lab.text = "[" + (i + stIndex + 1) + "]";
					lab.setStyle("fontWeight", "bold");
				}
				this.addElement(lab);
			}
			
			this.addElement(_goRightBtn);
			_goRightBtn.visible = this._currentIndex < this._totalSize - 1;
			this.addElement(_farRightBtn);
			_farRightBtn.visible = curPage < maxPage;
		}
		
		private function indexChangedHandler(evt:PaginationEvent):void
		{
			refreshLabelItems();
		}
		
		
		private function farLeftBtnClickHandler(evt:MouseEvent):void
		{
			this.currentIndex -= this._countPerPaging;
		}
		
		private function goLeftBtnClickHandler(evt:MouseEvent):void
		{
			this.currentIndex--;
		}
		
		private function farRightBtnClickHandler(evt:MouseEvent):void
		{
			this.currentIndex = Math.min(this._currentIndex + this._countPerPaging, this._totalSize - 1);
		}
		
		private function goRightBtnClickHandler(evt:MouseEvent):void
		{
			this.currentIndex++;
		}
		
		private function numLabelClickHandler(evt:MouseEvent):void
		{
			var lab:Label = Label(evt.currentTarget);
			if (lab.text.indexOf("[") < 0) {
				this.currentIndex = parseInt(lab.text) - 1;
			}
		}
		
	}
	
}

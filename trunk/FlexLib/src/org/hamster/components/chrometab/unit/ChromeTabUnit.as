package org.hamster.components.chrometab.unit
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import org.hamster.components.chrometab.ChromeTab;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.controls.Label;

	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * Used outside from ChromeTab is deprecated.
	 * 
	 * This component is a visible tab unit works for ChromeTab. the width
	 * and height and backgroundImage all comes from tabs of Google Chrome.
	 * 
	 */

	public class ChromeTabUnit extends Canvas
	{
		public static const DEFAULT_WIDTH:Number = 210;
		public static const DEFAULT_HEIGHT:Number = 25;
		
		[Embed(source='../assets/tab_selected.png')]
		private var tab_selected:Class;
		[Embed(source='../assets/tab_unselected.png')]
		private var tab_unselected:Class;
		
		// current location of this tab, this value will be changed when 
		// user changes the tabs location.
		public var index:int = -1;
		
		// the content data index of this tab, this value stands for the 
		// ViewStack children's index(if use ViewStack mode) or other index.
		// this value will not be changed when user change the tabs location.
		public var contentIndex:int = -1;
		
		// see getter/setter functions
		private var _label:String;
		private var _isSelected:Boolean;
		private var _chromeTab:ChromeTab;
		
		private var labelUnit:Label = new Label();
		private var closeUnit:Image = new Image();
		
		public function set labelText(arg:String):void
		{
			labelUnit.text = arg;
			this._label = arg;
		}
		
		public function get labelText():String
		{
			return this._label;
		}
		
		public function set isSelected(arg:Boolean):void
		{
			_isSelected = arg;
			arg
				? setStyle("backgroundImage", tab_selected)
				: setStyle("backgroundImage", tab_unselected);
			
		}
		
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set closeBtnVisible(arg:Boolean):void
		{
			this.closeUnit.visible = arg;
		}
		
		public function get closeBtnVisible():Boolean
		{
			return this.closeUnit.visible;
		}
		
		/**
		 * @param chromeTab, ordinary, the chromeTab should not be null.
		 */
		public function ChromeTabUnit(chromeTab:ChromeTab)
		{
			super();
			_chromeTab = chromeTab;
			setStyle("backgroundImage", tab_unselected);
			width = DEFAULT_WIDTH;
			height = DEFAULT_HEIGHT;
			
			labelUnit = new Label();
			labelUnit.setStyle("verticalCenter", 2);
			labelUnit.x = 12;
			labelUnit.setStyle("fontFamily", "arial");
			labelUnit.width = 190;
			addChild(labelUnit);
			
			closeUnit = new Image();
			closeUnit.width = 10;
			closeUnit.height = 10;
			closeUnit.setStyle("verticalCenter", 1);
			closeUnit.setStyle("right", 15);
			closeUnit.addEventListener(MouseEvent.ROLL_OVER, 
					closeBtnRollOverHandler);
			closeUnit.addEventListener(MouseEvent.ROLL_OUT, 
					closeBtnRollOutHandler);
			closeUnit.addEventListener(MouseEvent.CLICK, 
					closeTabHandler);
			closeBtnRollOutHandler();
			addChild(closeUnit);
		}
		
		private function closeTabHandler(evt:MouseEvent = null):void
		{
			if(_chromeTab != null) _chromeTab.closeTab(contentIndex);
		}
		
		private function closeBtnRollOutHandler(evt:MouseEvent = null):void
		{
			drawCloseBtn(true);
		}
		
		private function closeBtnRollOverHandler(evt:MouseEvent = null):void
		{
			drawCloseBtn(false);
		}
		
		/**
		 * use graphics method to draw the close tab button.
		 */
		private function drawCloseBtn(rollOut:Boolean):void
		{
			var alpha:Number = rollOut ? 0.01 : 1;
			var lineColor:Number = rollOut ? 0x7F7F7F : 0xFFFFFF;
			var g:Graphics = closeUnit.graphics;
			g.clear();
			g.lineStyle(1,0x7F0000, alpha);
			g.beginFill(0x7F0000, alpha);
			g.drawCircle(5, 5, 5);
			g.endFill();
			
			g.lineStyle(1, lineColor);
			g.moveTo(2, 2);
			g.lineTo(8, 8);
			g.moveTo(2, 8);
			g.lineTo(8, 2);			
		}
	}
}
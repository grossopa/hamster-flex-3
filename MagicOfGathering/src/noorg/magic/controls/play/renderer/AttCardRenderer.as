package noorg.magic.controls.play.renderer
{
	import flash.display.Graphics;
	
	public class AttCardRenderer extends DefCardRenderer
	{
		private var _isKilled:Boolean;
		
		public function set isKilled(value:Boolean):void
		{
			this._isKilled = value;
			//this.invalidateDisplayList();
		}
		
		public function get isKilled():Boolean
		{
			return this._isKilled;
		}
		
		public function AttCardRenderer()
		{
			super();
			
			this.dragEnabled = false;
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			var g:Graphics = this.mainImageOverlay.graphics;
			
			this.mainImageOverlay.setVisible(_isKilled);
			
			if (_isKilled) {
				g.beginFill(0x000000, 0.3);
				g.drawRect(0, 0, uw, uh);
				g.endFill();
			}
		}
		
	}
}
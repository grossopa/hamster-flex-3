package noorg.magic.controls.masks.drag
{
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	
	public class DragMaskInsertArrow extends DragMaskBase
	{
		private var _isLeft:Boolean;
		
		public function set isLeft(value:Boolean):void
		{
			this._isLeft = value;
			this.invalidateDisplayList();
		}
		
		public function get isLeft():Boolean
		{
			return this._isLeft;
		}
		
		public function DragMaskInsertArrow()
		{
			super();
			this.iconSource = AS.DragInsertArrow;
		}
		
		override protected function drawIcon(uw:Number, uh:Number):void
		{
			var bm:Bitmap = new iconSource;
			var m:Matrix = new Matrix();
			var rectWidth:Number =  uw * DragMaskBase.PERCENT_WIDTH;
			m.createBox(rectWidth / bm.width, rectWidth / bm.width, 0, rectWidth, rectWidth);
			m.translate(uw - rectWidth >> 1, uh - rectWidth >> 1);
			if (isLeft) {
				m.rotate(Math.PI);
				m.translate(uw - rectWidth >> 1, uh - rectWidth - 2);
			}
			this.graphics.beginBitmapFill(bm.bitmapData, m);
			this.graphics.drawRect(uw - rectWidth >> 1, uh - rectWidth >> 1, rectWidth, rectWidth);
			this.graphics.endFill();
			
			
		}
		
	}
}
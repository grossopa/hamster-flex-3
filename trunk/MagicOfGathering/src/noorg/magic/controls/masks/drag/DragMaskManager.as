package noorg.magic.controls.masks.drag
{
	import mx.collections.ArrayCollection;
	
	public class DragMaskManager
	{
		public const maskColl:ArrayCollection = new ArrayCollection();
		
		public function DragMaskManager()
		{
		}
		
		public function showMask():void
		{
			for each (var mask:DragMaskBase in this.maskColl) {
				if (mask.isEnabled = true) {
					mask.visible = true;
				} else {
					mask.visible = false;
				}
			}
		}
		
		public function hideMask():void
		{
			for each (var mask:DragMaskBase in this.maskColl) {
				mask.visible = false;
			}			
		}
		

	}
}
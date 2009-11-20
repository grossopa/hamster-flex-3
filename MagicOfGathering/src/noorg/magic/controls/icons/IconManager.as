package noorg.magic.controls.icons
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	import noorg.magic.utils.Constants;
	
	public class IconManager
	{
		private static const ICON_GAP:int = 2;
		
		public const iconArrColl:ArrayCollection = new ArrayCollection();
		public var left:int = ICON_GAP;
		public var top:int = ICON_GAP;
		
		public function IconManager()
		{
			iconArrColl.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
		}
		
		public function enableIcon(iconUnit:IconBase):void
		{
			iconUnit.isEnabled = true;
		}
		
		public function disableIcon(iconUnit:IconBase):void
		{
			iconUnit.isEnabled = false;
		}
		
		public function refreshLocation():void
		{
			var nextX:int = left;
			var nextY:int = top;
			
			for each (var icon:IconBase in this.iconArrColl) {
				if (icon.isEnabled == true && icon.isAutoTypeset) {
					icon.x = nextX;
					icon.y = nextY;
					nextX += Constants.ICON_WIDTH + ICON_GAP;
				} else {
					icon.visible = false;
				}
			}
		}
		
		public function showIcon():void
		{
			for each (var icon:IconBase in this.iconArrColl) {
				if (icon.isEnabled == true) {
					icon.visible = true;
				} else {
					icon.visible = false;
				}
			}
		}
		
		public function hideIcon():void
		{
			for each (var icon:IconBase in this.iconArrColl) {
				icon.visible = false;
			}			
		}
		
		private function collectionChangeHandler(evt:CollectionEvent):void
		{
			refreshLocation();
		}

	}
}
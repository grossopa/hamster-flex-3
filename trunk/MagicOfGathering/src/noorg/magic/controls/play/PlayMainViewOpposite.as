package noorg.magic.controls.play
{
	import mx.collections.ArrayCollection;
	
	public class PlayMainViewOpposite extends PlayMainView
	{
		public function PlayMainViewOpposite()
		{
			super();
		}
		
		override protected function completeHandler():void
		{
			super.completeHandler();
			
			var childrenCount:int = this.mainContainer.numChildren;
			var childList:ArrayCollection = new ArrayCollection(this.mainContainer.getChildren());
			for (var i:int = 0; i < childrenCount; i++) {
				this.mainContainer.setChildIndex(childList[i], childrenCount - 1 - i);
			}	
			
		}
		
	}
}
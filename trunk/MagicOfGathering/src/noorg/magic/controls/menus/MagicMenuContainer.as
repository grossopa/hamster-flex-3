package noorg.magic.controls.menus
{
	import mx.containers.VBox;
	import mx.core.ScrollPolicy;
	import mx.effects.Resize;
	import mx.effects.easing.Linear;

	public class MagicMenuContainer extends VBox
	{
		public static const RESIZE_DURATION:Number = 250;
		
		private var _resize:Resize;
		
		public function get isPlaying():Boolean
		{
			return _resize.isPlaying;
		}
		
		public function MagicMenuContainer()
		{
			super();
			
			this.width = 100;
			this.height = 200;
			this.setStyle("verticalGap", 0);
			this.setStyle("backgroundColor", 0xFFFFFF);
			this.setStyle("borderStyle", "solid");
			this.setStyle("borderThickness", 1);
			this.setStyle("borderColor", 0x000000);
			
			this.verticalScrollPolicy = ScrollPolicy.OFF;
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			
			_resize = new Resize(this);
			_resize.easingFunction = Linear.easeNone;
			_resize.duration = RESIZE_DURATION;
			_resize.heightFrom = 0;
		}
		
		public function addMenuItem(menuItem:MagicMenuItem):void
		{
			this.addMenuItemAt(menuItem, numChildren);
		}
		
		public function addMenuItemAt(menuItem:MagicMenuItem, index:int):void
		{
			this.addChildAt(menuItem, index);
		}
		
		public function removeMenuItem(menuItem:MagicMenuItem):MagicMenuItem
		{
			menuItem.clickFunction = null;
			return MagicMenuItem(this.removeChild(menuItem));
		}
		
		public function removeMenuItemAt(index:int):MagicMenuItem
		{
			return this.removeMenuItem(MagicMenuItem(this.getChildAt(index)));
		}
		
		public function removeAllMenuItems():void
		{
			this.removeAllChildren();
		}
		
		public function showMenu():void
		{
			this.visible = true;
			var toHeight:Number = 0;
			for each (var child:MagicMenuItem in this.getChildren()) {
				toHeight += child.height;
			}
			_resize.heightTo = toHeight;
			_resize.play();
		}
		
		public function hideMenu():void
		{
			this.visible = false;
		}
		
	}
}
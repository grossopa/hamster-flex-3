package noorg.magic.services
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import noorg.magic.actions.base.ICardAction;
	import noorg.magic.controls.menus.MagicMenuContainer;
	import noorg.magic.controls.menus.MagicMenuItem;
	import noorg.magic.controls.play.unit.PlayCardUnit;
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.staticValue.CardLocation;
	import noorg.magic.utils.GlobalUtil;
	
	public class MenuService
	{
		public static const CAST:String = "cast";
		
		public static const TO_HAND:String = "toHand";
		public static const TO_GALLERY:String ="toGallery";
		public static const TO_LAND:String = "toLand";
		public static const TO_MAGIC:String = "toMagic";
		public static const TO_ARTIFACT:String = "toArtifact";
		public static const TO_CREATURE:String = "toCreature";
		public static const TO_GRAVEYARD:String = "toGraveyard";
		public static const TO_OUT:String = "toOut";
		
		private static var _instance:MenuService;
		
		public static function getInstance():MenuService
		{
			if (_instance == null) {
				_instance = new MenuService();
			}
			return _instance;
		}
		
		public function MenuService()
		{
			GlobalUtil.app.addEventListener(MouseEvent.CLICK, appClickHandler);
			GlobalUtil.app.addChild(menuContainer);
			menuContainer.visible = false;
		}
		
		public const menuContainer:MagicMenuContainer = new MagicMenuContainer();
		public const menuItemArray:ArrayCollection = new ArrayCollection();
		
		public function showMenu(items:Array, stageX:Number, stageY:Number):void
		{
			menuContainer.removeAllMenuItems();
			
			for each (var item:MagicMenuItem in items) {
				menuContainer.addMenuItem(item);
			}
			
			if (stageX + menuContainer.width > GlobalUtil.app.width) {
				stageX = GlobalUtil.app.width - menuContainer.width;
			}
			
			menuContainer.x = stageX;
			menuContainer.y = stageY;
			menuContainer.showMenu();
		}
		
		public function hideMenu():void
		{
			menuContainer.visible = false;
		}
		
		public function getMenuItem(id:String, clickFunc:Function, clickData:Object, text:String = null):MagicMenuItem
		{
			var item:MagicMenuItem;
			for each (item in this.menuItemArray) {
				if (item.id == id) {
					item.clickFunction = clickFunc;
					item.clickData = clickData;
					if (text != null) {
						item.text = text;
					}
					return item;
				}
			}
			
			// if non-exists, then create a new item.
			item = new MagicMenuItem();
			item.id = id;
			item.text = text == null ? id : text;
			item.clickFunction = clickFunc;
			item.clickData = clickData;
			return item;
		}
		
		public var playCardUnit:PlayCardUnit;
		public function showPlayCardMenu(playCardUnit:PlayCardUnit, stageX:Number, stageY:Number):void
		{
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var menuList:Array = [];
			this.playCardUnit = playCardUnit;
			
			var playCard:PlayCard = this.playCardUnit.playCard;
			
			for (var i:int = 0; i < playCard.actionList.length; i++) {
				var action:ICardAction = playCard.getAction(i);
				var actionMenu:MagicMenuItem = this.getMenuItem(action.actType, 
					executeActionHandler, i, action.descriptionString);
				menuList.push(actionMenu);
			}
			
			var castMenu:MagicMenuItem;
			if (this.playCardUnit.playCard.getLocation() == CardLocation.HAND) {
				castMenu = this.getMenuItem(CAST,
						castHandler, null,
						resourceManager.getString('main', 'menu.cast'));
					
			}
			
			var toHandMenu:MagicMenuItem = this.getMenuItem(TO_HAND, 
					changeLocationHandler, CardLocation.HAND, 
					resourceManager.getString('main', 'menu.toHand'));
			var toLandMenu:MagicMenuItem = this.getMenuItem(TO_LAND,
					changeLocationHandler, CardLocation.LAND, 
					resourceManager.getString('main', 'menu.toLand'));
			var toCreatureMenu:MagicMenuItem = this.getMenuItem(TO_CREATURE,
					changeLocationHandler, CardLocation.CREATURE, 
					resourceManager.getString('main', 'menu.toCreature'));
			var toArtifactMenu:MagicMenuItem = this.getMenuItem(TO_ARTIFACT,
					changeLocationHandler, CardLocation.ARTIFACT,
					resourceManager.getString('main', 'menu.toArtifact'));
			var toMagicMenu:MagicMenuItem = this.getMenuItem(TO_MAGIC,
					changeLocationHandler, CardLocation.MAGIC,
					resourceManager.getString('main', 'menu.toMagic'));
			var toGraveyardMenu:MagicMenuItem = this.getMenuItem(TO_GRAVEYARD,
					changeLocationHandler, CardLocation.GRAVEYARD,
					resourceManager.getString('main', 'menu.toGraveyard'));
			var toOutMenu:MagicMenuItem = this.getMenuItem(TO_OUT,
					changeLocationHandler, CardLocation.OUT,
					resourceManager.getString('main', 'menu.toOut'));
			
			
			if (castMenu != null) {
				menuList.push(castMenu);
			}
			menuList.push(toHandMenu);
			menuList.push(toLandMenu);
			menuList.push(toCreatureMenu);
			menuList.push(toArtifactMenu);
			menuList.push(toMagicMenu);
			menuList.push(toGraveyardMenu);
			menuList.push(toOutMenu);
			 
			
			this.showMenu(menuList, stageX + playCardUnit.width, stageY + playCardUnit.height);
		}
		
		public function castHandler(clickData:Object):void
		{
			this.playCardUnit.playCard.cast();
		}
		
		public function changeLocationHandler(clickData:Object):void
		{
			playCardUnit.playCard.setLocation(int(clickData));
		}
		
		public function executeActionHandler(clickData:Object):void
		{
			var index:int = int(clickData);
			this.playCardUnit.playCard.executeAction(index);
			
			appClickHandler(null);	
		}
		
		private function appClickHandler(evt:MouseEvent):void
		{
			if (this.menuContainer.visible == true && !this.menuContainer.isPlaying) {
				this.menuContainer.x = 0;
				this.menuContainer.y = 0;
				this.menuContainer.hideMenu();
			}
			
		}
		
	}
}
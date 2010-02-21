package org.hamster.magic.common.utils
{
	public class Constants
	{
		public static const CARD_WIDTH:Number = 226;
		public static const CARD_HEIGHT:Number = 311;
		
		public static const CARD_RATIO:Number = new Number(CARD_HEIGHT / CARD_WIDTH);
		
		public static const PLAY_CARD_WIDTH:Number = 45;
		public static const PLAY_CARD_HEIGHT:Number = 60;
		
		public static const ICON_WIDTH:int = 20;
		public static const ICON_HEIGHT:int = 20;
		
		public static const MENU_ITEM_WIDTH:int = 100;
		public static const MENU_ITEM_HEIGHT:int = 20;
		public static const MENU_ITEM_LINE_HEIGHT:int = 3;
		
		
		public static const DEFAULT_GAP:int = 5;
		
		/**
		 * for play
		 */
		public static const PLAY_MOVE_GAP:Number = 311;
		
		public static const MAGIC_ICON_WIDTH:Number = 15;
		public static const MAGIC_ICON_HEIGHT:Number = 15;
		
		public static const DRAG_MASK_WIDTH:Number = PLAY_CARD_WIDTH / 3;
		public static const DRAG_MASK_HEIGHT:Number = PLAY_CARD_HEIGHT / 3;
		
		public static const RED_COLOR:Number 		= 0xFF2E2E;
		public static const GREEN_COLOR:Number 		= 0x00AA00;
		public static const BLUE_COLOR:Number 		= 0x005AFF;
		public static const BLACK_COLOR:Number 		= 0x000000;
		public static const WHITE_COLOR:Number 		= 0xAAAAAA;
		public static const COLORLESS_COLOR:Number 	= 0x7F7F7F;
		
		public static const RED:String			= "red";
		public static const GREEN:String 		= "green";
		public static const BLUE:String 		= "blue";
		public static const BLACK:String 		= "black";
		public static const WHITE:String 		= "white";
		public static const COLORLESS:String 	= "colorless";
		
		public static const MENU_MODULE:String = "/org/hamster/magic/menu/MenuModule.swf";
		public static const MODULE_PLAY:String = "/noorg/magic/controls/modules/PlayModule.swf";
	}
}
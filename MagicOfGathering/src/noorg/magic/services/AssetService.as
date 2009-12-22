package noorg.magic.services
{
	public class AssetService
	{
		private static var _instance:AssetService;
		
		public static function getInstance():AssetService
		{
			if (_instance == null) {
				_instance = new AssetService();
			}
			return _instance;
		}
		
		[Embed(source='noorg/magic/assets/common/common_delete.png')]
		public const CommonDelete:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_bg.png')]
		public const IconBackground:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_detail.png')]
		public const IconDetail:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_tap.png')]
		public const IconTap:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_returnHand.png')]
		public const IconReturnHand:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_enhancement.png')]
		public const IconEnhancement:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_revert.png')]
		public const IconRevert:Class;
		
		[Embed(source='noorg/magic/assets/icons/actions/action_magicPoolChange.png')]
		public const ActionMagicPoolChange:Class;
		
		[Embed(source='noorg/magic/assets/others/hp_damaged.png')]
		public const HPDamaged:Class;
		
		[Embed(source='noorg/magic/assets/others/hp_health.png')]
		public const HPHealth:Class;
		
		[Embed(source='noorg/magic/assets/cards/back.png')]
		public const CardBack:Class;
		
		//////////////////
		// icon related //
		//////////////////
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointBlack.png')]
		public const IconMagicPointBlack:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointBlue.png')]
		public const IconMagicPointBlue:Class;
	
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointGreen.png')]
		public const IconMagicPointGreen:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointWhite.png')]
		public const IconMagicPointWhite:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointRed.png')]
		public const IconMagicPointRed:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointColorless.png')]
		public const IconMagicPointColorless:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointBlack_30.png')]
		public const IconMagicPointBlack_30:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointBlue_30.png')]
		public const IconMagicPointBlue_30:Class;
	
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointGreen_30.png')]
		public const IconMagicPointGreen_30:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointWhite_30.png')]
		public const IconMagicPointWhite_30:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointRed_30.png')]
		public const IconMagicPointRed_30:Class;
		
		[Embed(source='noorg/magic/assets/magicPool/icon_magicPointColorless_30.png')]
		public const IconMagicPointColorless_30:Class;
		
		
		
		[Embed(source='noorg/magic/assets/icons/btn_list_expand.png')]
		public const BtnListExpand:Class;
		
		[Embed(source='noorg/magic/assets/icons/btn_list_hide.png')]
		public const BtnListHide:Class;
		
		[Embed(source='noorg/magic/assets/icons/btn_scrollRight.png')]
		public const BtnScrollRight:Class;
		
		[Embed(source='noorg/magic/assets/icons/btn_scrollLeft.png')]
		public const BtnScrollLeft:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_cardQuickMenu.png')]
		public const IconCardQuickMenu:Class;
		
		[Embed(source='noorg/magic/assets/icons/btn_ctrl_switchPlayer.png')]
		public const BtnSwitchPlayer:Class;
		
		[Embed(source='noorg/magic/assets/drag/drag_enhancement.png')]
		public const DragEnhancement:Class;
	
		[Embed(source='noorg/magic/assets/drag/drag_insertArrow.png')]
		public const DragInsertArrow:Class;

	}
}
package org.hamster.magic.common.services
{
	import mx.collections.ArrayCollection;
	
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.models.PlayCard;
	import org.hamster.magic.common.models.Player;
	import org.hamster.magic.common.utils.MapCollector;
	import org.hamster.magic.play.controls.units.PlayCardUnit;
	
	public class DataService 
	{
		private static var _instance:DataService;
		
		public static function getInstance():DataService
		{
			if (_instance == null) {
				_instance = new DataService();
			}
			return _instance;
		}
		
		/**
		 * all card collections
		 */
		[Bindable]
		public var cardCollections:ArrayCollection = new ArrayCollection();
//		
//		/**
//		 * current selected cards for build container
//		 */
//		[Bindable]
//		public var selectedCards:ArrayCollection = new ArrayCollection();
//		
		/**
		 * user saved cards name list
		 */
		[Bindable]
		public var userCollNames:ArrayCollection = new ArrayCollection();
		
//		[Bindable]
//		public var selectedNum:int;
		
//		public function selectedNumChanged():void
//		{
//			var result:int = 0;
//			for each (var card:Card in selectedCards) {
//				if (card.isSelected) {
//					result += card.count;
//				}
//			}
//			selectedNum = result;
//		}
		
		
		/**
		 * for play
		 */
		public var player1:Player;
		public var player2:Player;
		
		private var _playCardMap:MapCollector = new MapCollector();
//		
		public function getPlayCardUnitByCard(playCard:PlayCard):PlayCardUnit
		{
			var result:PlayCardUnit = PlayCardUnit(_playCardMap.getValue(playCard));
			if (result == null) {
				result = new PlayCardUnit();
				result.card = playCard;
				_playCardMap.put(playCard, result);
			}
			return result;
		}
		
		
//		
//		/**
//		 * user configurations
//		 */
//		[Bindable] 
//		public var isAutoShowCardDetail:Boolean = true;
//		[Bindable]
//		public var isAnimationEnabled:Boolean = true;
	}
}
package noorg.magic.services
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.controls.play.unit.PlayCardUnit;
	import noorg.magic.models.Card;
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	import noorg.magic.utils.MapCollector;
	
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
		
		/**
		 * current selected cards for build container
		 */
		[Bindable]
		public var selectedCards:ArrayCollection = new ArrayCollection();
		
		/**
		 * user saved cards name list
		 */
		[Bindable]
		public var userCollNames:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var selectedNum:int;
		
		public function selectedNumChanged():void
		{
			var result:int = 0;
			for each (var card:Card in selectedCards) {
				if (card.isSelected) {
					result += card.count;
				}
			}
			selectedNum = result;
		}
		
		
		/**
		 * for play
		 */
		public var playerRed:Player;
		public var playerBlue:Player;
		
		private var _playCardMap:MapCollector = new MapCollector();
		
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
		
		/**
		 * user configurations
		 */
		[Bindable] 
		public var isAutoShowCardDetail:Boolean = true;
	}
}
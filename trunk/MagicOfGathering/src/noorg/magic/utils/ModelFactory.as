package noorg.magic.utils
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.models.Card;
	import noorg.magic.models.CardCollection;
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	import noorg.magic.models.PlayerCardColl;
	
	public class ModelFactory
	{
		public static function createPlayer(cardColl:CardCollection):Player
		{
			var player:Player = new Player();
			player.cardColl = new CardCollection();
			player.cardColl.name = cardColl.name;
			player.cardColl.cards = new ArrayCollection();
			for each (var card:Card in cardColl.cards) {
				for (var i:int = 0; i < card.count; i++) {
					player.cardColl.cards.addItem(createPlayCard(card, player));
				}
			}
			
			player.playerCardColl = new PlayerCardColl(player.cardColl.cards);
			player.playerCardColl.shuffleCard(true);
			
			return player;
		}
		
		public static function createPlayCard(card:Card, ownPlayer:Player):PlayCard
		{
			var result:PlayCard = new PlayCard(ownPlayer);
			result.name = card.name;
			result.magicPool = card.magicPool.clone();
			if (card.type != null) {
				result.type = card.type.clone();
			}
			result.collection = card.collection;
			result.count = card.count;
			result.imgPath = card.imgPath;
			result.imgUrl = card.imgUrl;
			result.pid = card.pid;
			result.oracleText = card.oracleText;
			result.isSelected = true;
			result.actionManager = card.actionManager.clone();
			return result;
		}

	}
}
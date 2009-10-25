package noorg.magic.utils
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.models.Card;
	import noorg.magic.models.CardCollection;
	import noorg.magic.models.PlayCard;
	import noorg.magic.models.Player;
	import noorg.magic.models.staticValue.CardStatus;
	
	public class ModelFactory
	{
		public static function createPlayer(cardColl:CardCollection):Player
		{
			var player:Player = new Player();
			player.cardColl = new CardCollection();
			player.cardColl.name = cardColl.name;
			player.cardColl.cards = new ArrayCollection();
			for each (var card:Card in cardColl.cards) {
				player.cardColl.cards.addItem(createPlayCard(card));
			}
			return player;
		}
		
		public static function createPlayCard(card:Card):PlayCard
		{
			var result:PlayCard = new PlayCard();
			result.name = card.name;
			result.collection = card.collection;
			result.count = card.count;
			result.imgPath = card.imgPath;
			result.imgUrl = card.imgUrl;
			result.pid = card.pid;
			result.status = CardStatus.GALLERY;
			result.oracleText = card.oracleText;
			result.isSelected = true;
			return result;
		}

	}
}
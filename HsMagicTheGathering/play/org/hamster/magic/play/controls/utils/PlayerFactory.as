package org.hamster.magic.play.controls.utils
{
	import mx.collections.ArrayCollection;
	
	import org.hamster.magic.common.models.Card;
	import org.hamster.magic.common.models.CardCollection;
	import org.hamster.magic.common.models.PlayCard;
	import org.hamster.magic.common.models.Player;
	import org.hamster.magic.common.models.PlayerCards;
	import org.hamster.magic.common.models.action.CardAction;
	
	public class PlayerFactory
	{
		public static function createPlayer(cardColl:CardCollection):Player
		{
			var player:Player = new Player();
			player.cardCollection = new CardCollection();
			player.cardCollection.name = cardColl.name;
			player.cardCollection.cards = new ArrayCollection();
			for each (var card:Card in cardColl.cards) {
				for (var i:int = 0; i < card.count; i++) {
					player.cardCollection.cards.addItem(createPlayCard(card, player));
				}
			}
			
			player.playerCards = new PlayerCards(player.cardCollection.cards);
			player.playerCards.shuffleCard(true);
			
			return player;
		}
		
		public static function createPlayCard(card:Card, ownPlayer:Player):PlayCard
		{
			var result:PlayCard = new PlayCard(ownPlayer);
			result.name = card.name;
			result.magic.decodeString(card.magic.encodeString());
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
			if (card.actions != null) {
				result.actions = new Array();
				for each (var cardAction:CardAction in card.actions) {
					var cloneAction:CardAction = cardAction.clone();
					result.actions.push(cardAction);
				}
			}
			return result;
		}

	}
}
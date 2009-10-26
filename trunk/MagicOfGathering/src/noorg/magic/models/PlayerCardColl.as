package noorg.magic.models
{
	import mx.collections.ArrayCollection;
	
	public class PlayerCardColl
	{
		public static const typeCount:int
		
		public function PlayerCardColl(cardColl:ArrayCollection)
		{
			this.cardColl = cardColl;
		}
		
		public var cardColl:ArrayCollection;
		
		[Bindable]
		public const cardStack:ArrayCollection = new ArrayCollection();
		
//		public static const GALLERY:int = 0;
//		public static const HAND:int = 1;
//		public static const ARTIFACT:int = 2;
//		public static const ARTIFACT_ENHANCEMENT:int = 21;
//		public static const CREATURE:int = 3;
//		public static const CREATURE_ENHANCEMENT:int = 31;
//		public static const MAGIC:int = 4;
//		public static const MAGIC_ENHANCEMENT:int = 41;
//		public static const GRAVEYARD:int = 5;
		
//		[Bindable]
//		public const cardsInGallery:ArrayCollection = new ArrayCollection();
//		[Bindable]
//		public const cardsInHand:ArrayCollection = new ArrayCollection();
//		[Bindable]
//		public const cardsInArtifact:ArrayCollection = new ArrayCollection();
//		[Bindable]
//		public const cardsInArtifactEnhancement:ArrayCollection = new ArrayCollection();
//		[Bindable]
//		public const cardsInCreature:ArrayCollection = new ArrayCollection();
//		[Bindable]
//		public const cardsInCreatureEnhancement:ArrayCollection = new ArrayCollection();
//		[Bindable]
//		public const cardsInMagic:ArrayCollection = new ArrayCollection();
//		[Bindable]
//		public const cardsInMagicEnhancement:ArrayCollection = new ArrayCollection();
//		[Bindable]
//		public const cardsInGraveyard:ArrayCollection = new ArrayCollection();
		
		
		public function shuffleCard(isNewCardStack = false):void
		{
			if (isNewCardStack) {
				cardStack.removeAll();
				for each (var card:PlayCard in cardColl) {
					cardStack.addItem(card);
				}
			}
			
			for(i = 0; i < length; i++) {  
				j = int(Math.random() * length);
				CommonArrayUtil.swapArray(cardStack, i, j);
			}
		}
		
		public function dragCard():PlayCard
		{
			if (this.cardStack.length == 0) {
				return null;
			} else {
				return PlayCard(this.cardStack.removeItemAt(this.cardStack.length - 1));
			}
		}
		
		private function registCardListener(card:PlayCard):void
		{
			
		}
		
		private function unregistCardListener(card:PlayCard):void
		{
			
		}

	}
}
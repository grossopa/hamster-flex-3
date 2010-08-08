package org.hamster.mapleCard.main.components.battleField
{
	import flash.events.Event;
	
	import org.hamster.mapleCard.assets.style.BattleFieldItemStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.components.images.EffectImage;
	import org.hamster.mapleCard.base.event.GameEvent;
	import org.hamster.mapleCard.base.services.EventService;
	
	public class BattleFieldMaskContainer extends SimpleContainer
	{
		private var ES:EventService = EventService.instance;
		
		public function BattleFieldMaskContainer()
		{
			super();
			this._measuredWidth = 525;
			this._measuredHeight = 500;
		}
		
		override protected function addedToStageHandler(evt:Event):void
		{
			super.addedToStageHandler(evt);
			
			ES.addEventListener(GameEvent.ATTACK_START, attackStartHandler);
		}
		
		private function attackStartHandler(evt:GameEvent):void
		{
			var effectImg:EffectImage = new EffectImage("attack_1");
			this.addChild(effectImg);
			effectImg.x = evt.defender.xIndex * BattleFieldItemStyle.WIDTH;
			effectImg.y = evt.defender.yIndex * BattleFieldItemStyle.HEIGHT;
		}
	}
}
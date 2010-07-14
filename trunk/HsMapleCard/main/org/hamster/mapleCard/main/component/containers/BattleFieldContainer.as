package org.hamster.mapleCard.main.component.containers
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.hamster.mapleCard.main.component.units.BattleFieldUnit;

	public class BattleFieldContainer extends UIComponent
	{
		public static const ROW_COUNT:int = 5;
		public static const COL_COUNT:int = 7;
		
		public function BattleFieldContainer()
		{
			this.width = 525;
			this.height = 500;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(evt:Event):void
		{
			if (this.numChildren == 0) {
				var allCount:int = ROW_COUNT * COL_COUNT;
				for (var i:int = 0; i < allCount; i++) {
					var unit:BattleFieldUnit = new BattleFieldUnit();
					unit.x = (i % COL_COUNT) * 75;
					unit.y = Math.floor(i / COL_COUNT) * 100;
					trace (unit.x + "    " + unit.y);
					this.addChild(unit);
				}
			}
		}
		
		
		
	}
}
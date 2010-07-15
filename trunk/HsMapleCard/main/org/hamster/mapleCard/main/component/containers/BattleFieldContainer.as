package org.hamster.mapleCard.main.component.containers
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.components.images.CreatureImage;
	import org.hamster.mapleCard.main.component.units.BattleFieldUnit;

	public class BattleFieldContainer extends SimpleContainer
	{
		public static const ROW_COUNT:int = 5;
		public static const COL_COUNT:int = 7;
		
		public function BattleFieldContainer()
		{
			this._measuredWidth = 525;
			this._measuredHeight = 500;
	//		this.width = 525;
	//		this.height = 500;
			this.addEventListener(Event.ADDED, addedHandler);
		}
		
		protected function addedHandler(evt:Event):void
		{
			if (this.numChildren == 0) {
				var allCount:int = ROW_COUNT * COL_COUNT;
				for (var i:int = 0; i < allCount; i++) {
					var unit:BattleFieldUnit = new BattleFieldUnit();
					unit.x = (i % COL_COUNT) * 75;
					unit.y = Math.floor(i / COL_COUNT) * 100;
					this.addChild(unit);
				}
			}
		}
		
		public function addCreature(creature:CreatureImage, xIndex:int, yIndex:int):void
		{
			
		}
		
		
		
	}
}
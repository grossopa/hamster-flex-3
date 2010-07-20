package org.hamster.mapleCard.main.components.battleField
{
	import mx.effects.AnimateProperty;
	import mx.effects.Effect;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.Tween;
	import mx.effects.TweenEffect;
	import mx.effects.easing.Linear;
	import mx.effects.effectClasses.TweenEffectInstance;
	
	import org.hamster.mapleCard.assets.style.BattleFieldItemStyle;
	import org.hamster.mapleCard.assets.style.BattleFieldStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.event.BattleFieldItemDataEvent;
	import org.hamster.mapleCard.base.services.DataService;
	import org.hamster.mapleCard.base.services.GameService;
	
	import spark.effects.Animate;
	
	public class BattleFieldItemContainer extends SimpleContainer
	{
		private static const GS:GameService = GameService.instance;
		
		public function BattleFieldItemContainer()
		{
			super();
			this._measuredWidth = BattleFieldStyle.WIDTH;
			this._measuredHeight = BattleFieldStyle.HEIGHT;
		}
		
		public function addBattleFieldItem(item:BattleFieldItem, xIndex:int, yIndex:int):void
		{
			var xValue:Number = xIndex * BattleFieldItemStyle.WIDTH;
			var yValue:Number = yIndex * BattleFieldItemStyle.HEIGHT;
			
			this.addChild(item);
			addItemListener(item);
			
			item.x = xValue;
			item.y = yValue;
			
			GS.addBattleFieldItemData(item.battleFieldData);
		}
		
		protected function itemIndexChangedHandler(evt:BattleFieldItemDataEvent):void
		{
			var item:BattleFieldItem = BattleFieldItem(evt.currentTarget);
			moveItemTo(item, evt.newXIndex, evt.newYIndex);
		}
		
		public function moveItemTo(item:BattleFieldItem, xIdx:int, yIdx:int):void
		{
			var xValue:Number = xIdx * BattleFieldItemStyle.WIDTH;
			var yValue:Number = yIdx * BattleFieldItemStyle.HEIGHT;
			
			var length:Number = Math.sqrt((xValue - item.x) * (xValue - item.x)
				+ (yValue - item.y) * (yValue - item.y));
			
			var duration:Number = length * 5;
			
			var aniPropertyX:AnimateProperty = new AnimateProperty(item);
			aniPropertyX.property = "x";
			aniPropertyX.fromValue = item.x;
			aniPropertyX.toValue = xValue;
			aniPropertyX.duration = duration;
			aniPropertyX.easingFunction = Linear.easeNone;
			var aniPropertyY:AnimateProperty = new AnimateProperty(item);
			aniPropertyY.property = "y";
			aniPropertyY.fromValue = item.y;
			aniPropertyY.toValue = yValue;
			aniPropertyY.duration = duration;
			aniPropertyY.easingFunction = Linear.easeNone;
			var parallel:Parallel = new Parallel();
			parallel.addChild(aniPropertyX);
			parallel.addChild(aniPropertyY);
			parallel.play();
			//item.x = xValue;
			//item.y = yValue;
			
		}
		
		protected function addItemListener(item:BattleFieldItem):void
		{
			item.addEventListener(BattleFieldItemDataEvent.INDEX_CHANGED, itemIndexChangedHandler);
		}
		
		protected function removeItemListener(item:BattleFieldItem):void
		{
			item.removeEventListener(BattleFieldItemDataEvent.INDEX_CHANGED, itemIndexChangedHandler);
		}
		
		
		
		
	}
}
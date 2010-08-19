package org.hamster.mapleBattle.main.component.buildTile.model
{
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	import org.hamster.mapleCard.base.model.base.BaseModel;
	
	public class BuildItemVO extends BaseModel
	{
		private var _battleFieldItemData:IBattleFieldItemData;
		private var _moneyCost:Number;
		
		override public function set id(value:String):void { }
		override public function get id():String { return _battleFieldItemData.id; }
		public function get battleFieldItemData():IBattleFieldItemData { return _battleFieldItemData; }
		public function set moneyCost(value:Number):void { _moneyCost = value }
		public function get moneyCost():Number { return _moneyCost }
		
		
		public function BuildItemVO(itemData:IBattleFieldItemData)
		{
			super();
			_battleFieldItemData = itemData;
		}
	}
}
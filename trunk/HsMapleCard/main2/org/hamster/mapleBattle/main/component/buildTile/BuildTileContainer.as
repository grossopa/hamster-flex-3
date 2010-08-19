package org.hamster.mapleBattle.main.component.buildTile
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	import org.hamster.mapleBattle.main.component.buildTile.model.BuildItemVO;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.model.player.Player;
	
	public class BuildTileContainer extends SimpleContainer
	{
		private var _tileItemDataList:ArrayCollection = new ArrayCollection();
		
		private var _parentPlayer:Player;
		public function get parentPlayer():Player { return _parentPlayer }
		public function get tileItemDataList():ArrayCollection { return _tileItemDataList }
		
		public function BuildTileContainer(player:Player)
		{
			super();
			this._parentPlayer = player;
			this._measuredWidth = 300;
			this._measuredHeight = 40;
			
			_tileItemDataList.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
			
			this.graphics.lineStyle(1);
			this.graphics.drawRect(0,0,300, 40);
		}
		
		private function collectionChangeHandler(evt:CollectionEvent):void
		{
			if (evt.kind == CollectionEventKind.ADD) {
				var itemVO:BuildItemVO = evt.items[0];
				var newItem:BuildTileItem = new BuildTileItem(itemVO);
				newItem.x = this.numChildren * 40;
				this.addChild(newItem);
			}
		}
		
		
	}
}
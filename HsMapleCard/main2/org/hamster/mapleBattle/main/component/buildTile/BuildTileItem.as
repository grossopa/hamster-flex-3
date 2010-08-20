package org.hamster.mapleBattle.main.component.buildTile
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.hamster.mapleBattle.main.component.buildTile.model.BuildItemVO;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.components.images.BaseImage;

	public class BuildTileItem extends SimpleContainer
	{
		private var _loadingMask:Sprite = new Sprite();
		private var _baseImage:BaseImage = new BaseImage();
		
		private var _buildItemVO:BuildItemVO;
		public function get buildItemVO():BuildItemVO { return _buildItemVO }
		
		public function BuildTileItem(buildItemVO:BuildItemVO)
		{
			super();
			_buildItemVO = buildItemVO;
			
			this._measuredWidth = 40;
			this._measuredHeight = 40;
			
			this.addChild(_baseImage);
			this.addChild(_loadingMask);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		protected function onEnterFrameHandler(evt:Event):void
		{
			refreshImage();
		}
		
		private function refreshImage():void
		{
			if ((_baseImage.imgArray == null || _baseImage.imgArray.length == 0)
				&& this.buildItemVO != null) {
				this._baseImage.initializeFromImgArray([this.buildItemVO.battleFieldItemData.itemIcon]);
			}
		}
		
		
		
		
		
		
		
	}
}
package org.hamster.mapleCard.main.component.units
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import mx.controls.Image;
	
	import org.hamster.mapleCard.base.components.images.BaseImage;
	import org.hamster.mapleCard.base.constants.BaseImagePlayMethod;
	import org.hamster.mapleCard.base.constants.BattleFieldUnitStatus;
	import org.hamster.mapleCard.base.constants.Constants;
	import org.hamster.mapleCard.base.constants.CreatureStatus;
	import org.hamster.mapleCard.base.services.DataService;
	
	public class BattleFieldUnit extends BaseImage
	{
		[Embed(source="/org/hamster/mapleCard/assets/battleField/battleFieldUnit.png")]
		private static var battleFieldClass:Class;
		
		private static const DS:DataService = DataService.instance;
		
		private var _status:String = BattleFieldUnitStatus.NORMAL;
		public function set status(value:String):void 
		{
			this._status = value;
			this._currentImgIndex = 0;
		}
		public function get status():String { return this._status; }
		
		public function BattleFieldUnit()
		{
			super();
			
			this.width = 75;
			this.height = 100;
			this._playMethod == BaseImagePlayMethod.NORMAL;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(evt:Event):void
		{
			var defaultKey:String = Constants.BATTLE_FIELD_KEY_PREFIX + BattleFieldUnitStatus.NORMAL;
			var bitmap:Bitmap;
			
			if (!DS.imageCacheManager.exists(defaultKey)) {
				bitmap = new battleFieldClass();
				DS.imageCacheManager.put(defaultKey, bitmap);
				trace ("Put " + defaultKey + " to image cache.")
			}
			bitmap = Bitmap(DS.imageCacheManager.get(defaultKey));
			initializeFromImgArray([bitmap]);
		}
		
		
		
//		override protected function updateDisplayContent():void
//		{
//			
//		}
	}
}
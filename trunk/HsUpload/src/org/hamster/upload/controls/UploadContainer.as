package org.hamster.upload.controls
{
	import mx.collections.ArrayCollection;
	import mx.containers.Tile;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	import org.hamster.upload.models.UploadFile;
		
	public class UploadContainer extends Tile
	{
		public function UploadContainer()
		{
			super();
		}
		

		private var _uploadFiles:ArrayCollection;
		
		public function set uploadFiles(value:ArrayCollection):void
		{
			if (_uploadFiles != null) {
				unregisterListener();
			}
			this._uploadFiles = value;
			registerListener();
		}
		
		public function get uploadFiles():ArrayCollection
		{
			return _uploadFiles;
		}
		
		private function registerListener():void
		{
			_uploadFiles.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
		}
		
		private function unregisterListener():void
		{
			_uploadFiles.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
		}
		
		private function collectionChangedHandler(evt:CollectionEvent):void
		{
			var file:UploadFile;
			var child:UploadUnit;
			var hasIt:Boolean;
			
			if (evt.kind == CollectionEventKind.REMOVE) {
				for each (child in this.getChildren()) {
					hasIt = false;
					for each (file in _uploadFiles) {
						if (child.file == file) {
							hasIt = true;
						}
					}
					if (!hasIt) {
						this.removeChild(child);
					}
				}
			} else if (evt.kind == CollectionEventKind.ADD) {
				for each (file in _uploadFiles) {
					hasIt = false;
					for each (child in this.getChildren()) {
						if (child.file == file) {
							hasIt = true;
						}
					}
					if (!hasIt) {
						var newItem:UploadUnit = new UploadUnit();
						newItem.file = file;
						this.addChild(newItem);
					}
				}
			}
			
		}
		
	}
}
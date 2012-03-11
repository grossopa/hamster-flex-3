package org.hamster.dropboxTool.view.components
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	
	import mx.collections.ArrayCollection;
	
	import org.hamster.dropbox.models.DropboxFile;
	import org.hamster.dropboxTool.constant.AppConstants;
	import org.hamster.dropboxTool.event.DropboxItemEvent;
	import org.hamster.dropboxTool.view.components.fileList.FileListDetailsViewMediator;
	import org.hamster.framework.puremvc.HsMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	public class FileWindowMediator extends HsMediator
	{
		public static const NAME:String = "FileWindowMediator";
		
		public function FileWindowMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			new FileListDetailsViewMediator(app.fileListDetailsView);
			
			app.addressTI.addEventListener(KeyboardEvent.KEY_UP, addressTIKeyUpHandler);
			app.fileListDetailsView.addEventListener(DropboxItemEvent.DROPBOX_ITEM_SELECTED, fileList_dropboxItemSelectedHandler);
			
			this.sendNotification(AppConstants.METADATA_REQUEST);
		}
		
		override public function onRemove():void
		{
			facade.removeMediator(FileListDetailsViewMediator.NAME);
			
			app.addressTI.removeEventListener(KeyboardEvent.KEY_UP, addressTIKeyUpHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppConstants.METADATA_RESULT,
				AppConstants.METADATA_FAULT,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppConstants.METADATA_RESULT:
					handleMetadataResult(notification.getBody());
					break;
				case AppConstants.METADATA_FAULT:
					handleMetadataFault(notification.getBody());
					break;
			}
		}
		
		private function handleMetadataResult(data:Object):void
		{
			var result:DropboxFile = DropboxFile(data);
			app.dropboxFile = result;
		}
		
		private function handleMetadataFault(data:Object):void
		{
		}
		
		private function addressTIKeyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ENTER && app.dropboxFile != null 
				&& app.dropboxFile.path != app.addressTI.text) {
				sendNotification(AppConstants.METADATA_REQUEST, app.addressTI.text);
			}
		}
		
		private function fileList_dropboxItemSelectedHandler(event:DropboxItemEvent):void
		{
			var dropboxFile:DropboxFile = event.dropboxFile;
			if (dropboxFile.isDir) {
				this.sendNotification(AppConstants.METADATA_REQUEST, dropboxFile.path);
			}
		}
		
		public function get app():FileWindow
		{
			return FileWindow(getViewComponent());
		}
		
		
	}
}
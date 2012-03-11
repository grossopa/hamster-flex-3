package org.hamster.dropboxTool.view.components.fileList
{
	import org.hamster.dropbox.models.DropboxFile;
	import org.hamster.dropboxTool.event.DropboxItemEvent;
	import org.hamster.framework.puremvc.HsMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import spark.events.GridEvent;
	
	public class FileListDetailsViewMediator extends HsMediator
	{
		public static const NAME:String = 'FileListDetailsViewMediator';
		
		public function FileListDetailsViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			app.mainDataGrid.addEventListener(GridEvent.GRID_CLICK, mainDataGrid_gridClickHandler);
		}
		
		override public function onRemove():void
		{
			app.mainDataGrid.removeEventListener(GridEvent.GRID_CLICK, mainDataGrid_gridClickHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
			
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
		
		protected function mainDataGrid_gridClickHandler(event:GridEvent):void
		{
			var disEvt:DropboxItemEvent = new DropboxItemEvent(DropboxItemEvent.DROPBOX_ITEM_SELECTED);
			disEvt.dropboxFile = DropboxFile(event.item);
			this.app.dispatchEvent(disEvt);
		}
		
		public function get app():FileListDetailsView
		{
			return FileListDetailsView(getViewComponent());
		}
	}
}
package noorg.commands.impl
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	import noorg.models.album.BackgroundImage;
	import noorg.models.album.PageStyle;
	import noorg.utils.ArrayColUtil;
	import noorg.utils.Constants;
	
	import org.hamster.commands.AbstractCommand;

	public class LoadPageInfoCommand extends AbstractCommand
	{
		private var _pageStyles:ArrayCollection = new ArrayCollection();
		private var _bgImgs:ArrayCollection = new ArrayCollection();
		
		private var missionCount:int;
		
		public function get pageStyles():ArrayCollection
		{
			return _pageStyles;
		}
		
		public function get bgImgs():ArrayCollection
		{
			return _bgImgs;
		}
		
		public function LoadPageInfoCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var pageFileRoot:File = new File(Constants.PAGE_FILE_FOLDER);
			var list:Array;
			var fs:FileStream;
			
			if (pageFileRoot.exists) {
				list = pageFileRoot.getDirectoryListing();
				for each (var pageFile:File in list) {
					fs = new FileStream();
					fs.addEventListener(Event.COMPLETE, pageLoadCompleteHandler);
					fs.openAsync(pageFile, FileMode.READ);
					
					this.missionCount++;
				}
			} else {
				this.fault(null);
			}
			
			var bgImgFileRoot:File = new File(Constants.BACKROUND_IMAGE_FILE_FOLDER);
			if (bgImgFileRoot.exists) {
				list = bgImgFileRoot.getDirectoryListing();
				for each (var bgImgFile:File in list) {
					if (!bgImgFile.isDirectory && ArrayColUtil.hasValue(
							bgImgFile.type, Constants.SUPPORTED_IMAGE_TYPE)) {
						fs = new FileStream();
						fs.addEventListener(Event.COMPLETE, bgImgLoadCompleteHandler);
						fs.openAsync(bgImgFile, FileMode.READ);
						
						this.missionCount++;
					}
				}
			} else {
				this.fault(null);
			}

		}

		
		private function pageLoadCompleteHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			fs.removeEventListener(Event.COMPLETE, pageLoadCompleteHandler);
			var contents:String = fs.readUTFBytes(fs.bytesAvailable);
			this.addPage(contents);
			this.missionFinished();
		}
		
				
		private function bgImgLoadCompleteHandler(evt:Event):void
		{
			var fs:FileStream = FileStream(evt.currentTarget);
			fs.removeEventListener(Event.COMPLETE, bgImgLoadCompleteHandler);
			var imgBytes:ByteArray = new ByteArray(); 
			fs.readBytes(imgBytes, 0, fs.bytesAvailable);
			this.addBgImg(imgBytes);
			this.missionFinished();
		}
		
		private function addPage(str:String):void
		{
			var xml:XML = XML(str);
			var pageStyle:PageStyle = new PageStyle(xml);
			_pageStyles.addItem(pageStyle);
		}
		
		private function addBgImg(byteArray:ByteArray):void
		{
			var bgImg:BackgroundImage = new BackgroundImage(byteArray);
			_bgImgs.addItem(bgImg);
		}
		
		private function missionFinished():void
		{
			this.missionCount--;
			if (missionCount == 0) {
				this.result(null);
			}
		}
		

		
	}
}
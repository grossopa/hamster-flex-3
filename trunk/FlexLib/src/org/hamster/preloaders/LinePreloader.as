package org.hamster.preloaders
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;

	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class LinePreloader extends DownloadProgressBar
	{
		private var txt:TextField;
		private var _preloader:Sprite;
		private var maxTextX:int;
		private var nextX:int;
		private var imgMaxScale:Number; // 0~1
		private static const HTMLTEXT_FRONT:String 
				= "<font face='Verdana' size='10pt'>";
		private static const HTMLTEXT_END:String = "</font>";
		
		private var img:Bitmap;
		[Embed(source="assets/loading.png")]
		private var LoadingBar:Class;
			
		public function LinePreloader() 
		{
			super();
			img = new LoadingBar();
			addChild(img);
			txt = new TextField();
			txt.width = 200;
			txt.height = 20;
			txt.selectable = false;
			addChild(txt);
		}
	
		override public function set preloader(value:Sprite):void
		{
			_preloader = value;
			img.height = 5;
			imgMaxScale = stage.stageWidth / img.width;
			img.width = stage.stageWidth;
			img.scaleX = 0;
			maxTextX = stage.stageWidth - 50;
		
			_preloader.addEventListener(ProgressEvent.PROGRESS,load_progress);
			_preloader.addEventListener(Event.COMPLETE,load_complete);
			_preloader.addEventListener(FlexEvent.INIT_PROGRESS,init_progress);
			_preloader.addEventListener(FlexEvent.INIT_COMPLETE,init_complete);
			stage.addEventListener(Event.RESIZE,resize);
			
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
				
			resize(null);
		}

		private function remove():void 
		{
			_preloader.removeEventListener(ProgressEvent.PROGRESS,load_progress);
			_preloader.removeEventListener(Event.COMPLETE,load_complete);
			_preloader.removeEventListener(FlexEvent.INIT_PROGRESS,init_progress);
			_preloader.removeEventListener(FlexEvent.INIT_COMPLETE,init_complete);
			stage.removeEventListener(Event.RESIZE,resize);
		}

		private function resize(e:Event):void
		{
			img.x = 0;
			img.y = stage.stageHeight - 5 >> 1;
			txt.x = 0;
			txt.y = img.y - 15;
		}

		private function load_progress(e:ProgressEvent):void
		{
			var percent:Number = e.bytesLoaded / e.bytesTotal;
			img.scaleX = percent * imgMaxScale;
			var percentText:int = Math.ceil(percent * 100);
			txt.htmlText = LinePreloader.HTMLTEXT_FRONT + percentText.toString()
					 + "%" + LinePreloader.HTMLTEXT_END;
			nextX = percent * stage.stageWidth - 15;
			txt.x = txt.x >= maxTextX || nextX > maxTextX
					? maxTextX : nextX;
		}

		private function load_complete(e:Event):void{
			txt.htmlText = LinePreloader.HTMLTEXT_FRONT 
		 			+ "Load Complete!" + LinePreloader.HTMLTEXT_END;
		}

		private function init_progress(e:FlexEvent):void{
			txt.htmlText = LinePreloader.HTMLTEXT_FRONT 
					+ "Initializing..." + LinePreloader.HTMLTEXT_END;
			txt.x = stage.stageWidth - 80;
		}

		private function init_complete(e:FlexEvent):void{
			txt.htmlText = LinePreloader.HTMLTEXT_FRONT
					+ "Done!" + LinePreloader.HTMLTEXT_END;
			remove();
			dispatchEvent(new Event(Event.COMPLETE))
		}
	}
}
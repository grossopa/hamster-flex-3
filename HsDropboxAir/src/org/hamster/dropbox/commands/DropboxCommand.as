package org.hamster.dropbox.commands
{
	import com.adobe.serialization.json.JSONDecoder;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.dropbox.models.DropboxModelSupport;
	
	public class DropboxCommand extends AbstractCommand
	{
		private var _urlRequest:URLRequest;
		private var _resultType:Class;
		private var _params:Object;
		
		public var resultObject:Object;
		
		public function DropboxCommand(urlRequest:URLRequest, resultType:Class = null, params:Object = null)
		{
			super();
			
			this._urlRequest = urlRequest;
			this._resultType = resultType;
			this._params = params;
		}
		
		override public function execute():void
		{
			var urlLoader:URLLoader = new URLLoader();
			if (_resultType == null || _resultType != ByteArray) {
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			} else {
				urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			}
			urlLoader.addEventListener(Event.COMPLETE, result);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, fault);
			urlLoader.load(_urlRequest);
		}
		
		override public function result(data:Object):void
		{
			var urlLoader:URLLoader = URLLoader(data.currentTarget);
			urlLoader.removeEventListener(Event.COMPLETE, result);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, fault);
			var resultData:Object = urlLoader.data;
			
			if (resultData is String) {
				if (this._resultType != null) {
					if (resultData == 'OK') {
						super.result(data);
					} else {
						var obj:Object = new JSONDecoder(resultData.toString()).getValue();
						this.resultObject = new this._resultType;
						if (obj != null) {
							this.resultObject.decode(obj);
						}
					}
				}
			} else if (resultData is ByteArray) {
				this.resultObject = ByteArray(resultData);
			}
			
			super.result(data);
		}
		
		override public function fault(info:Object):void
		{
			var urlLoader:URLLoader = URLLoader(info.currentTarget);
			urlLoader.removeEventListener(Event.COMPLETE, result);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, fault);
			
			super.fault(info);
		}
		
	}
}
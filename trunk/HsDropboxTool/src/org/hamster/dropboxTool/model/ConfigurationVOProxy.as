package org.hamster.dropboxTool.model
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.utils.ArrayUtil;
	import mx.utils.ObjectUtil;
	
	import org.hamster.dropboxTool.constant.AppConstants;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ConfigurationVOProxy extends Proxy
	{
		public static const NAME:String = "ConfigurationVOProxy";
		
		public static const CONFIG_FILE:String = File.applicationStorageDirectory.nativePath 
			+ File.separator + "config.properties";
		
		public var configurationVO:ConfigurationVO;
		private var confFile:File;
		
		public function ConfigurationVOProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function load():void
		{
			var fs:FileStream = new FileStream();
			fs.addEventListener(Event.COMPLETE, openCompleteHandler);
			fs.addEventListener(IOErrorEvent.IO_ERROR, openIOErrorHandler);
			fs.openAsync(new File(CONFIG_FILE), FileMode.READ);
		}
		
		private function openCompleteHandler(event:Event):void
		{
			var fs:FileStream = FileStream(event.currentTarget);
			var content:String = fs.readUTFBytes(fs.bytesAvailable);
			var arr:Array = content.split(AppConstants.LINE_SEP_N);
			
			var result:ConfigurationVO = new ConfigurationVO();
			configurationVO = new ConfigurationVO();
			
			for each (var str:String in arr) {
				var keyValue:Array = str.split("=");
				var key:String 		= keyValue[0];
				var value:String 	= keyValue[1];
				
				if (result.hasOwnProperty(key)) {
					if (configurationVO.hasOwnProperty(key) && configurationVO[key] is Array) {
						result[key] = value.split(',');
					} else {
						result[key] = value;
					}
					if (configurationVO.hasOwnProperty(key) && result[key] != "") {
						configurationVO[key] = result[key];
					}
				}
			}
			
			configurationVO.data = result;
			
			fs.close();
			
			this.sendNotification(AppConstants.CONFIGURATION_LOAD_RESULT, configurationVO);
		}
		
		private function openIOErrorHandler(event:IOErrorEvent):void
		{
			this.configurationVO = new ConfigurationVO();
			this.sendNotification(AppConstants.CONFIGURATION_LOAD_FAULT, null);
		}
		
		public function save():void
		{
			var fs:FileStream = new FileStream();
//			fs.addEventListener(Event.COMPLETE, saveOpenCompleteHandler);
			fs.openAsync(new File(CONFIG_FILE), FileMode.WRITE);
			var str:String = "";
			
			var objInfo:Object = ObjectUtil.getClassInfo(configurationVO); 
			var fieldName:Array = objInfo["properties"] as Array; 
			for each(var q:QName in fieldName){ 
				if (q.localName == 'data') {
					continue;
				}
				if (configurationVO[q.localName] is Array) {
					str += q.localName + "=" + (configurationVO[q.localName] as Array).join(',');
				} else {
					str += q.localName + "=" + configurationVO[q.localName];
				}
				
				str += AppConstants.LINE_SEP_N;
			} 
			
			fs.writeUTFBytes(str);
			
			fs.close();
			
			this.sendNotification(AppConstants.CONFIGURATION_SAVE_RESULT, configurationVO);
		}
		
	}
}
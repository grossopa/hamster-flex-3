import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import mx.controls.Alert;

import org.hamster.dropbox.DropboxAPI;
import org.hamster.dropbox.DropboxConfig;

public var dropAPI:DropboxAPI;

public function appCompleteHandler():void
{
	var config:DropboxConfig = new DropboxConfig();
	config.setConsumer('wnl0erseogu50mk', 'eypos93aukcysdw');
	dropAPI = new DropboxAPI(config);
}

public function getRequestToken():void
{
	var req:URLLoader = dropAPI.requestToken();
	loader.addEventListener(Event.COMPLETE, function ():void
	{
		var result:String = loader.data;
		
		// handle result data by DropboxAPI
		
		accTokenKeyLabel.text = result;
	});
	loader.addEventListener(IOErrorEvent.IO_ERROR, faultHandler);
	loader.load(req);
}

private function faultHandler(evt:Event):void
{
	Alert.show(evt.toString());
}
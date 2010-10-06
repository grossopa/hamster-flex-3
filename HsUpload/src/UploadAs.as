// ActionScript file
import flash.events.DataEvent;
import flash.net.FileFilter;
import flash.net.URLRequestMethod;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.rpc.AsyncToken;
import mx.rpc.IResponder;
import mx.rpc.Responder;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.mxml.HTTPService;

import org.hamster.upload.HsUpload;
import org.hamster.upload.events.HsUploadEvent;
import org.hamster.upload.models.UploadFile;

private var responder:IResponder;

private var sessId:String = "sessTest";

private var hsUpload:HsUpload = new HsUpload();

// private const map:MapCollector = new MapCollector();

private function uploadHandler():void
{
	hsUpload.browseFile();
}

public function appCompleteHandler():void
{
	responder = new mx.rpc.Responder(deleteResult, deleteFault);
	uploadContainer.uploadFiles = new ArrayCollection(hsUpload.files);
	hsUpload.url = "http://localhost:8000/upload/uploadImage/";
	var fileFliter:FileFilter = new FileFilter('Image files', '*.jpg;*.png;*.gif');
	hsUpload.fileFliters = [fileFliter];
	hsUpload.addEventListener(HsUploadEvent.FILE_FINISHED, fileFinishedHandler);
	hsUpload.addEventListener(HsUploadEvent.FILE_FINISHED_THEN_DELETE, fileFinishedThenDeleteHandler);
	hsUpload.addEventListener(HsUploadEvent.TASK_FINISHED, taskFinishedHandler);
	hsUpload.addEventListener(HsUploadEvent.FILE_DELETE, fileDeleteHandler);
}

private function fileDeleteHandler(evt:HsUploadEvent):void
{
	var uploadFile:UploadFile = UploadFile(evt.uploadFile);
	
	var service:HTTPService = new HTTPService();
	service.url = "http://localhost:8000/upload/deleteImage/"
			+ "?fileName=" + uploadFile.name;
	service.method = URLRequestMethod.POST;
	service.resultFormat = "text";
	var asyncToken:AsyncToken = service.send();
	asyncToken.addResponder(responder);
}

private function deleteResult(data:Object):void
{
	var resultEvt:ResultEvent = ResultEvent(data);
	Alert.show(resultEvt.result.toString());
}

private function deleteFault(info:Object):void
{
	Alert.show(info.toString());
}

private function fileFinishedHandler(evt:HsUploadEvent):void
{
	var dataEvt:DataEvent = DataEvent(evt.evt);
	var xml:XML = new XML(dataEvt.text);
	var uploadFile:UploadFile = UploadFile(evt.uploadFile);
	uploadFile.name = xml.attribute("file-name");
	uploadFile.url = "http://localhost:8000/upload/uploadImage/"
			+ "?fileName=" + xml.attribute('file-name');
}

private function fileFinishedThenDeleteHandler(evt:HsUploadEvent):void
{
	fileFinishedHandler(evt);
	fileDeleteHandler(evt);
}

private function taskFinishedHandler(evt:HsUploadEvent):void
{
	Alert.show("upload finished!");
}


// ActionScript file
import flash.events.DataEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;

import org.hamster.upload.events.HsUploadEvent;
import org.hamster.upload.models.UploadFile;
import org.hamster.upload.models.UploadFileStatus;

[Embed(source='org/hamster/upload/assets/loading.swf')]
private const loadingSwf:Class;

[Bindable]
private var _uploadProgress:String;
[Bindable]
private var _fileSize:String;
[Bindable]
private var _source:Object;

private var _file:UploadFile;

public function set file(value:UploadFile):void
{
	if (_file != null) {
		trace("[UploadUnit.unregisterListener]");
		unregisterListener();
	}
	this._file = value;
	this.registerListener();
	
	var fs:Number = _file.file.size;
	if (fs < 1024) {
		_fileSize = fs + "B";
	} else if (fs >= 1024 && fs < 1024 * 1024) {
		_fileSize = int(fs / 1024) + "KB";
	} else if (fs > 1024 * 1024 && fs < 1024 * 1024 * 1024) {
		_fileSize = int(fs / 1024 / 1024) + "MB";
	} else {
		_fileSize = int(fs / 1024 / 1024) + "MB";
	}
	
	if (_file.url != null && _file.url.length != 0 && _source != null && _source.toString() != _file.url) {
		_source = _file.url;
	} else if (_file.status == UploadFileStatus.PROGRESS || _file.status == UploadFileStatus.UPLOADED) {
		_source = loadingSwf;
	} else if (_file.status == UploadFileStatus.NOT_START) {
		_source = "";
	} else if (_file.status == UploadFileStatus.FAILED) {
		_source = "";
	}
}

public function get file():UploadFile
{
	return _file;
}

private function deleteHandler():void
{
	_file.deleteFile();
	trace("[" + toString() + ".deleteHandler] ");
}

private function registerListener():void
{
	_file.addEventListener(HsUploadEvent.FILE_PROGRESS, fileProgressHandler);
	_file.addEventListener(HsUploadEvent.FILE_UPLOADED, fileUploadedHandler);
	_file.addEventListener(HsUploadEvent.FILE_FINISHED, fileFinishedHandler);
	_file.addEventListener(HsUploadEvent.FILE_ERROR, fileErrorHandler);
}

private function unregisterListener():void
{
	_file.removeEventListener(HsUploadEvent.FILE_PROGRESS, fileProgressHandler);
	_file.removeEventListener(HsUploadEvent.FILE_UPLOADED, fileUploadedHandler);
	_file.removeEventListener(HsUploadEvent.FILE_FINISHED, fileFinishedHandler);
	_file.removeEventListener(HsUploadEvent.FILE_ERROR, fileErrorHandler);	
}

private function fileProgressHandler(evt:HsUploadEvent):void
{
	_source = loadingSwf;
	uploadProgressLabel.visible = true;
	var progressEvt:ProgressEvent = ProgressEvent(evt.evt);
	_uploadProgress = int(progressEvt.bytesLoaded / progressEvt.bytesTotal * 100) + "%";
	trace("[" + toString() + ".fileProgressHandler] " + _uploadProgress);
}

private function fileUploadedHandler(evt:HsUploadEvent):void
{
	uploadProgressLabel.visible = false;
	trace("[" + toString() + ".fileUploadedHandler] " + _uploadProgress);
}

private function fileFinishedHandler(evt:HsUploadEvent):void
{
	var dataEvt:DataEvent = DataEvent(evt.evt);
	_source = file.url;
	trace("[" + toString() + ".fileFinishedHandler] " + _source);
}

private function fileErrorHandler(evt:HsUploadEvent):void
{
	trace("[" + toString() + ".fileErrorHandler] " + evt.evt.toString());	
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	this.graphics.clear();
	
	this.graphics.lineStyle(1, 0x7F7F7F);
	this.graphics.beginFill(0x000000);
	this.graphics.drawRect(0, 0, uw, uh);
	this.graphics.endFill();
}

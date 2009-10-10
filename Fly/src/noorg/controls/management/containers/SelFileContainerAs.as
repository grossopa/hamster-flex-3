// ActionScript file
import flash.events.Event;
import flash.events.FileListEvent;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.net.FileFilter;

import mx.collections.ArrayCollection;
import mx.core.DragSource;
import mx.core.UIComponent;
import mx.managers.DragManager;

import noorg.controls.album.units.ImageUnit;
import noorg.controls.management.units.SelImageUnit;
import noorg.events.SelFileEvent;
import noorg.services.DataService;
import noorg.utils.ArrayColUtil;
import noorg.utils.factories.ModelObjFactory;

private const DS:DataService = DataService.getInstance();

private static const IMG_FILE_FILTER:FileFilter = new FileFilter("Supported images", "*.jpg;*.gif;*.png");
private var _fileList:ArrayCollection = new ArrayCollection();

private function completeHandler():void
{
	
}

private function selectImgFiles():void
{
	var fileSel:File = new File();
	fileSel.browseForOpenMultiple("Select Image Files:", [IMG_FILE_FILTER]);
	fileSel.addEventListener(FileListEvent.SELECT_MULTIPLE, selectedFilesHandler);
}

private function selectedFilesHandler(evt:FileListEvent):void
{
	var temp:ArrayCollection = new ArrayCollection(evt.files);
	ArrayColUtil.connect(_fileList, temp);
	
	if (temp.length == 0) {
		trace("no files selected!");
		return;
	} else {
		var firstFile:File = File(temp[0]);
		this.loadFile(firstFile);
	}
}

private function delImgHandler(evt:SelFileEvent):void
{
	var curUnit:SelImageUnit = SelImageUnit(evt.currentTarget);
	var childrenArray:Array = mainTile.getChildren();
	for (var i:int = curUnit.index + 1; i < mainTile.numChildren; i++) {
		var selImg:SelImageUnit = SelImageUnit(childrenArray[i]);
		selImg.index--;
	}
	DS.imageDatas.removeItemAt(curUnit.index);
	_fileList.removeItemAt(curUnit.index);
	mainTile.removeChild(curUnit);
}

private function loadFile(file:File):void
{
	file.addEventListener(Event.COMPLETE, loadFileCompleteHandler);
	file.load();
}

private function loadFileCompleteHandler(evt:Event):void
{
	var file:File = File(evt.currentTarget);
	var index:int = _fileList.getItemIndex(file);
	file.removeEventListener(Event.COMPLETE, loadFileCompleteHandler);
	if (index == _fileList.length - 1) {
		// all completed
		showImage();
	} else {
		loadFile(File(_fileList[index + 1]));
	}
}

private function showImage():void
{
	var index:int = this.mainTile.numChildren;
	var startDelay:int = 0;
	for (var i:int = index; i < _fileList.length; i++) {
		var file:File = File(_fileList[i]);
		var imgUnit:SelImageUnit = new SelImageUnit();
		imgUnit.width = mainTile.tileWidth;
		imgUnit.height = mainTile.tileHeight;
		imgUnit.file = file;
		imgUnit.index = index;
		imgUnit.startDelay = startDelay;
		imgUnit.addEventListener(SelFileEvent.DELETE_IMG, delImgHandler);
		imgUnit.imageData = ModelObjFactory.createImageDataByFile(file);
		DS.imageDatas.addItem(imgUnit.imageData);
		addSelImgUnit(imgUnit);
		index++;
		startDelay++;
	}
}

private function addSelImgUnit(imgUnit:SelImageUnit):void
{
	this.mainTile.addChild(imgUnit);
	imgUnitAddListener(imgUnit);
}

private function removeSelImgUnit(imgUnit:SelImageUnit):void
{
	this.mainTile.removeChild(imgUnit);
	imgUnitRemoveListener(imgUnit);
}

private function imgUnitAddListener(imgUnit:SelImageUnit):void
{
	imgUnit.addEventListener(MouseEvent.MOUSE_DOWN, imgUnitMouseDownHandler);
}

private function imgUnitRemoveListener(imgUnit:SelImageUnit):void
{
	imgUnit.removeEventListener(MouseEvent.MOUSE_DOWN, imgUnitMouseDownHandler);
}

private function imgUnitMouseDownHandler(evt:MouseEvent):void
{
	if (evt.buttonDown && !DragManager.isDragging) {
		var ds:DragSource = new DragSource();
		ds.addData({"x":evt.localX, "y":evt.localY}, "xy");
		DragManager.doDrag(UIComponent(evt.currentTarget), ds, evt);
	}
}
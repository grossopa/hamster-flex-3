// ActionScript file
import flash.events.NativeDragEvent;
import flash.filesystem.File;

public function nativeDragEnterHandler(evt:NativeDragEvent):void
{
	
}

public function nativeDragDropHandler(evt:NativeDragEvent):void
{
	
}

public function execute():void
{
	var folder:File = new File(folderInput.text);
	var files:Array = folder.getDirectoryListing();
	var index:int = 1;
	for each (var file:File in files) {
		if (file.name.indexOf("___") < 0) {
			var fName:String = "";
			if (index <= 9) {
				fName = "0" + index.toString();
			} else {
				fName = index.toString();
			}
			fName += ".jpg";
			file.moveTo(new File(folder.nativePath + File.separator + this.prefixInput.text + "___" + fName));
			index++;
		}
	}
}

public function undo():void
{
	var folder:File = new File(folderInput.text);
	var files:Array = folder.getDirectoryListing();
	for each (var file:File in files) {
		if (file.name.indexOf(this.prefixInput.text + "___") >= 0) {
			file.moveTo(new File(folder.nativePath + File.separator + file.name.replace(this.prefixInput.text + "___", "")));
		}
	}	
}
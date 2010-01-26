// ActionScript file
import flash.filesystem.File;

import mx.controls.Alert;

import org.hamster.gamesaver.services.DataService;
import org.hamster.gamesaver.utils.Constants;

private static const DS:DataService = DataService.getInstance();

private function completeHandler():void
{
	Alert.show(this.findAccessableDrives().toString());
}

private function findAccessableDrives():Array
{
	var array:Array = new Array();
	for each (var drive:String in Constants.DRIVES) {
		var f:File = new File(drive);
		if (f.isDirectory) {
			array.push(drive);
		}
	}
	return array;
}

private function addDriveHandler():void
{
	var newDrive:String = this.driveInput.text;
	
	if (newDrive != null && newDrive.length > 0 
			&& !DS.driveArray.contains(newDrive)) {
		DS.driveArray.addItem(newDrive);		
	}
}

private function mainStackChangeHandler():void
{
	headerLabel.text = this.mainStack.selectedChild.label;
}
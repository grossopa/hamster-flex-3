// ActionScript file
import flash.events.Event;
import flash.filesystem.File;

import org.hamster.gamesaver.controls.units.FilterUnit;
import org.hamster.gamesaver.events.ChildComponentEvent;
import org.hamster.gamesaver.events.TextInputEvent;
import org.hamster.gamesaver.models.Game;

private var _game:Game;
private var _gameChanged:Boolean;
private var _editable:Boolean;

public function set editable(value:Boolean):void
{
	this._editable = value;
	for each (var filterUnit:FilterUnit in this.filterContainer.getChildren()) {
		filterUnit.editable = value;
	}
}

[Bindable]
public function get editable():Boolean
{
	return this._editable;
}

public function set game(value:Game):void
{
	this._game = value;
	_gameChanged = true;
}

public function get game():Game
{
	return this._game;
}

private function completeHandler():void
{
	if (_gameChanged) {
		_gameChanged = false;
		this.editable = false;
		this.titleInput.text = game.name;
		this.pathInput.text = game.path;
		this.savePathInput.text = game.savePath;
		this.filterContainer.removeAllChildren();
		for each (var inStr:String in game.includes) {
			this.addFilterUnit(inStr, FilterUnit.INCLUDE);
		}
		for each (var exStr:String in game.excludes) {
			this.addFilterUnit(exStr, FilterUnit.EXCLUDE);
		}
	}
}

private function addFilterClickHandler():void
{
	if (!this.editable) {
		return;
	}
	addFilterUnit("", FilterUnit.INCLUDE);
}

private function filterUnitApplyChangeHandler(evt:TextInputEvent):void
{
	var removeArray:Array = new Array();
	for (var i:int = 0; i < this.filterContainer.numChildren; i++) {
		var unit1:FilterUnit = FilterUnit(this.filterContainer.getChildAt(i));
		for (var j:int = i + 1; j < this.filterContainer.numChildren; j++) {
			var unit2:FilterUnit = FilterUnit(this.filterContainer.getChildAt(j));
			if (unit1.filterText == unit2.filterText
				&& removeArray.indexOf(unit1) < 0) {
				removeArray.push(unit1);
			}
		}
	}
	
	for each (var unit3:FilterUnit in removeArray) {
		removeFilterUnit(unit3);
	}
}

private function addFilterUnit(filterText:String, type:String):void
{
	var newFilterUnit:FilterUnit = new FilterUnit();
	newFilterUnit.filterText = filterText;
	newFilterUnit.type = type;
	newFilterUnit.addEventListener(TextInputEvent.APPLY_CHANGE, filterUnitApplyChangeHandler);
	newFilterUnit.addEventListener(ChildComponentEvent.DELETE, deleteFilterUnitHandler);
	this.filterContainer.addChild(newFilterUnit);
}

private function removeFilterUnit(unit:FilterUnit):void
{
	unit.removeEventListener(TextInputEvent.APPLY_CHANGE, filterUnitApplyChangeHandler);
	unit.removeEventListener(ChildComponentEvent.DELETE, deleteFilterUnitHandler);
	this.filterContainer.removeChild(unit);	
}

private function browsePathFolderHandler():void
{
	if (!this.editable) {
		return;
	}
	var folder:File = new File();
	folder.addEventListener(Event.SELECT, pathSelectHandler);
	folder.browseForDirectory("");
}

private function pathSelectHandler(evt:Event):void
{
	var folder:File = File(evt.currentTarget);
	folder.removeEventListener(Event.SELECT, pathSelectHandler);
	this.pathInput.text = folder.nativePath;
}

private function browseSavePathFolderHandler():void
{
	if (!this.editable) {
		return;
	}
	var folder:File = new File();
	folder.addEventListener(Event.SELECT, savePathSelectHandler);
	folder.browseForDirectory("");	
}

private function savePathSelectHandler(evt:Event):void
{
	var folder:File = File(evt.currentTarget);
	folder.removeEventListener(Event.SELECT, savePathSelectHandler);
	this.savePathInput.text = folder.nativePath;
}


private function deleteFilterUnitHandler(evt:Event):void
{
	var unit:FilterUnit = FilterUnit(evt.currentTarget);
	removeFilterUnit(unit);
}

private function deleteClickHandler():void
{
	var disEvt:ChildComponentEvent = 
			new ChildComponentEvent(ChildComponentEvent.DELETE);
	this.dispatchEvent(disEvt);
}

private function editButtonClickHandler():void
{
	this.editable = true;
}

private function okButtonClickHandler():void
{
	this.editable = false;
	applyChanges();
}

public function applyChanges():void
{
	this.editable = false;
	game.name = this.titleInput.text;
	game.path = this.pathInput.text;
	game.savePath = this.savePathInput.text;
	
	while (this.game.includes.length > 0) {
		this.game.includes.pop();
	}
	
	while (this.game.excludes.length > 0) {
		this.game.excludes.pop();
	}
	
	for each (var filter:FilterUnit in this.filterContainer.getChildren()) {
		if (filter.type == FilterUnit.INCLUDE) {
			this.game.includes.push(filter.filterText);
		} else {
			this.game.excludes.push(filter.filterText);
		}
	}
}


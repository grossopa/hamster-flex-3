// ActionScript file
import flash.events.MouseEvent;

import mx.binding.utils.BindingUtils;
import mx.containers.ViewStack;
import mx.controls.Button;
import mx.core.Container;
import mx.core.IFactory;
import mx.events.ChildExistenceChangedEvent;
import mx.events.IndexChangedEvent;

private var _bindViewStack:ViewStack;
private var _selectedIndex:int;

public var tabRenderer:IFactory;
public var tabWidth:Number = 100;
public var tabHeight:Number = 20;

public function get selectedIndex():int
{
	return this._selectedIndex;
}

public function set selectedIndex(value:int):void
{
	this._selectedIndex = value;
	if (this.bindViewStack != null) {
		this.bindViewStack.selectedIndex = value;
	}
	
}

public function get bindViewStack():ViewStack
{
	return _bindViewStack;
}

public function set bindViewStack(value:ViewStack):void
{
	if (this._bindViewStack != null) {
		_bindViewStack.removeEventListener(ChildExistenceChangedEvent.CHILD_ADD, addTabHandler);
		_bindViewStack.removeEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, removeTabHandler);
		_bindViewStack.removeEventListener(IndexChangedEvent.CHANGE, indexChangedHandler);		
	}
	this._bindViewStack = value;
	value.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, addTabHandler);
	value.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, removeTabHandler);
	value.addEventListener(IndexChangedEvent.CHANGE, indexChangedHandler);
	refreshTabItem();
}

private function addTabHandler(evt:ChildExistenceChangedEvent):void
{
	var newTab:Button = this.addTab(Container(evt.relatedObject));
	if (this.numChildren == 1) {
		newTab.selected = true;
	}
}

private function removeTabHandler(evt:ChildExistenceChangedEvent):void
{
	for each (var child:Button in this.getChildren()) {
		if (child.data == evt.relatedObject) {
			this.removeChild(child);
		}
	}
}

private function indexChangedHandler(evt:IndexChangedEvent):void
{
	Button(getChildAt(evt.newIndex)).selected = true;
	Button(getChildAt(evt.oldIndex)).selected = false;
}

private function refreshTabItem():void
{
	this.removeAllChildren();
	for each (var child:Container in this.bindViewStack.getChildren()) {
		this.addTab(child);
	}
}

private function clickTabHandler(evt:MouseEvent):void
{
	var tab:Button = Button(evt.currentTarget);
	if (bindViewStack != null) {
		bindViewStack.selectedChild = Container(tab.data);
	}
}

private function addTab(child:Container):Button
{
	var newTab:Button = Button(tabRenderer.newInstance());
	newTab.data = child;
	newTab.width = tabWidth;
	newTab.height = tabHeight;
	newTab.addEventListener(MouseEvent.CLICK, clickTabHandler);
	BindingUtils.bindProperty(newTab, "label", child, ["label"]);
	return Button(this.addChild(newTab));
}
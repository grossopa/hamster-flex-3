// ActionScript file
import flash.events.Event;

import mx.collections.ArrayCollection;

import org.hamster.magic.common.services.DataService;

private static const DS:DataService = DataService.getInstance();
[Bindable]
private var userCollNames:ArrayCollection;

private function completeHandler():void
{
	userCollNames = DS.userCollNames;
}

private function startGameHandler():void
{
	this.dispatchEvent(new Event("startGame"));
}
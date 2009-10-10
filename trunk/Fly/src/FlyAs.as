// ActionScript file
import flash.events.Event;

import mx.controls.Alert;

import noorg.commands.impl.LoadPageInfoCommand;
import noorg.events.CommandEvent;
import noorg.events.InitDataEvent;
import noorg.services.DataService;
import noorg.services.EventService;
import noorg.utils.ArrayColUtil;

import org.hamster.commands.impl.CommandQueue;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private function completeHandler():void
{
	var loadPageInfoCmd:LoadPageInfoCommand = new LoadPageInfoCommand();
	loadPageInfoCmd.addEventListener(CommandEvent.COMMAND_RESULT, loadCompleteHandler);
	loadPageInfoCmd.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	var queue:CommandQueue = new CommandQueue([loadPageInfoCmd]);
	queue.addEventListener(CommandEvent.COMMAND_RESULT, resultHandler);
	queue.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	queue.execute();
}

private function loadCompleteHandler(evt:Event):void
{
	var cmd:LoadPageInfoCommand = LoadPageInfoCommand(evt.currentTarget);
	DS.pageStyles.removeAll();
	DS.bgImgs.removeAll();
	ArrayColUtil.connect(DS.pageStyles, cmd.pageStyles);
	ArrayColUtil.connect(DS.bgImgs, cmd.bgImgs);
}

private function resultHandler(evt:Event):void
{
	ES.dispatchEvent(new InitDataEvent(InitDataEvent.INIT_DATA_COMPLETE));
}

private function faultHandler(evt:Event):void
{
	Alert.show("fault");
}
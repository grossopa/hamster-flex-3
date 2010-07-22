import flash.display.Bitmap;
import flash.filesystem.File;

import mx.events.FlexEvent;

import org.hamster.commands.events.CommandEvent;
import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.components.images.CreatureImage;
import org.hamster.mapleCard.base.constants.Constants;
import org.hamster.mapleCard.base.constants.CreatureStatus;
import org.hamster.mapleCard.base.event.GameEvent;
import org.hamster.mapleCard.base.model.IActionStackItemData;
import org.hamster.mapleCard.base.model.IBattleFieldItemData;
import org.hamster.mapleCard.base.model.battleField.CreatureBattleFieldItemData;
import org.hamster.mapleCard.base.model.player.Player;
import org.hamster.mapleCard.base.services.DataService;
import org.hamster.mapleCard.base.services.EventService;
import org.hamster.mapleCard.base.utils.FileUtil;
import org.hamster.mapleCard.main.components.actionStack.ActionStackContainer;
import org.hamster.mapleCard.main.components.battleField.BattleFieldContainer;
import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;

private static const DS:DataService = DataService.instance;
private static const ES:EventService = EventService.instance;

private var _battleFieldContainer:BattleFieldContainer;
private var _actionStackContainer:ActionStackContainer;
private var _battleFieldItem:BattleFieldItem;
private var _testCreatureImage:CreatureImage;

protected function windowedapplication1_applicationCompleteHandler(event:FlexEvent):void
{
	_battleFieldContainer = new BattleFieldContainer();
	sv2.addChild(_battleFieldContainer);
	_actionStackContainer = new ActionStackContainer();
	sv3.addChild(_actionStackContainer);
}

public function testCreatureImageLoaderCommand():void
{
	var creatureLoaderCmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd.execute("0100100");
	creatureLoaderCmd.addEventListener(CommandEvent.COMMAND_RESULT, creatureLoaderResultHandler);
}

public function creatureLoaderResultHandler(evt:CommandEvent):void
{
	var creatureLoaderCmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
	DS.imageCacheManager.put(Constants.CREATE_KEY_PREFIX + creatureLoaderCmd.creatureImageInfo.uid, 
		creatureLoaderCmd.creatureImageInfo);
	
	var player:Player = new Player();
	player.color = 0xdd0000;
	
//	_testCreatureImage = new CreatureImage("0100100");
//	_testCreatureImage.x = this.sv.numChildren * 50;
//	_testCreatureImage.direction = (this.sv.numChildren % 2 == 0) ? "left" : "right";
	
	var battleFieldData:CreatureBattleFieldItemData = new CreatureBattleFieldItemData();
	battleFieldData.id = Constants.CREATE_KEY_PREFIX + "0100100";
	battleFieldData.maxHp = 10;
	battleFieldData.hp = 3;
	battleFieldData.actionProgress = Math.random() * 100;
	battleFieldData.actionStackIcon = creatureLoaderCmd.creatureImageInfo.icon;
	battleFieldData.parentPlayer = player;
	
	var disEvt:GameEvent = new GameEvent(GameEvent.ADD_BATTLEFIELDITEMDATA);
	disEvt.battleFieldItemData = battleFieldData;
	ES.dispatchEvent(disEvt);
	
//	this._battleFieldContainer.addBattleFieldItem(_battleFieldItem, 0, 0);
}

private function pickUpNextItem():void
{
	var data:IActionStackItemData = _actionStackContainer.pickUpNextActionItem();
	data.actionProgress += 50;
}

private function moveBattleFieldItem():void
{
	_battleFieldItem.battleFieldData.setIndex(2, 4);
}

private function creatureDie():void
{
	this._testCreatureImage.status = CreatureStatus.DIE;
}

private function creatureStand():void
{
	this._testCreatureImage.status = CreatureStatus.STAND;
}

private function creatureHit():void
{
	this._testCreatureImage.status = CreatureStatus.HIT;
}

private function creatureWalk():void
{
	this._testCreatureImage.status = CreatureStatus.MOVE;
}
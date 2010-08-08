import flash.display.Bitmap;
import flash.filesystem.File;

import mx.events.FlexEvent;

import org.hamster.commands.events.CommandEvent;
import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.components.images.CreatureImage;
import org.hamster.mapleCard.base.components.images.EffectImage;
import org.hamster.mapleCard.base.constants.Constants;
import org.hamster.mapleCard.base.constants.CreatureStatus;
import org.hamster.mapleCard.base.event.GameEvent;
import org.hamster.mapleCard.base.model.IActionStackItemData;
import org.hamster.mapleCard.base.model.IBattleFieldItemData;
import org.hamster.mapleCard.base.model.battleField.CreatureBattleFieldItemData;
import org.hamster.mapleCard.base.model.player.Player;
import org.hamster.mapleCard.base.services.DataService;
import org.hamster.mapleCard.base.services.EventService;
import org.hamster.mapleCard.base.services.GameService;
import org.hamster.mapleCard.base.utils.FileUtil;
import org.hamster.mapleCard.main.components.actionStack.ActionStackContainer;
import org.hamster.mapleCard.main.components.battleField.BattleFieldContainer;
import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;

private static const DS:DataService = DataService.instance;
private static const ES:EventService = EventService.instance;
private static const GS:GameService = GameService.instance;

private var _battleFieldContainer:BattleFieldContainer;
private var _actionStackContainer:ActionStackContainer;
private var _battleFieldItem:BattleFieldItem;
private var _attackerData:CreatureBattleFieldItemData;
private var _defenderData:CreatureBattleFieldItemData;
private var _testCreatureImage:CreatureImage;
private var _testEffectImage:EffectImage;

protected function windowedapplication1_applicationCompleteHandler(event:FlexEvent):void
{
	_battleFieldContainer = new BattleFieldContainer();
	sv2.addChild(_battleFieldContainer);
	
	// _testEffectImage = new EffectImage("attack_1");
	
	_actionStackContainer = new ActionStackContainer();
	sv3.addChild(_actionStackContainer);
	// sv2.addChild(_testEffectImage);
}

public function testCreatureImageLoaderCommand():void
{
	var creatureLoaderCmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd.execute("0100100");
	creatureLoaderCmd.addEventListener(CommandEvent.COMMAND_RESULT, creatureLoaderResultHandler);
}

public function creatureLoaderResultHandler(evt:CommandEvent):void
{
	var creatureLoaderCmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
	DS.imageCacheManager.put(Constants.CREATE_KEY_PREFIX + creatureLoaderCmd.creatureImageInfo.id, 
		creatureLoaderCmd.creatureImageInfo);
	
	var player1:Player = new Player();
	player1.direction = "right";
	player1.color = 0xdd0000;
	
	var player2:Player = new Player();
	player2.direction = "left";
	player2.color = 0x0000dd;
	
//	_testCreatureImage = new CreatureImage("0100100");
//	_testCreatureImage.x = this.sv.numChildren * 50;
//	_testCreatureImage.direction = (this.sv.numChildren % 2 == 0) ? "left" : "right";
	
	var battleFieldData:CreatureBattleFieldItemData = new CreatureBattleFieldItemData();
	battleFieldData.id = Constants.CREATE_KEY_PREFIX + "0100100";
	battleFieldData.maxHp = 10;
	battleFieldData.hp = 3;
	battleFieldData.actionProgress = Math.random() * 100;
	battleFieldData.actionStackIcon = creatureLoaderCmd.creatureImageInfo.icon;
	battleFieldData.parentPlayer = player1;
	
	_attackerData = new CreatureBattleFieldItemData();
	_attackerData.id = Constants.CREATE_KEY_PREFIX + "0100100";
	CreatureBattleFieldItemData(_attackerData).maxHp = 10;
	_attackerData.hp = 10;
	_attackerData.xIndex = 3;
	_attackerData.yIndex = 3;
	_attackerData.actionProgress = Math.random() * 100;
	_attackerData.actionStackIcon = creatureLoaderCmd.creatureImageInfo.icon;
	_attackerData.parentPlayer = player1;
	
	_defenderData = new CreatureBattleFieldItemData();
	_defenderData.id = Constants.CREATE_KEY_PREFIX + "0100100";
	CreatureBattleFieldItemData(_defenderData).maxHp = 10;
	_defenderData.hp = 10;
	_defenderData.xIndex = 4;
	_defenderData.yIndex = 3;
	_defenderData.actionProgress = Math.random() * 100;
	_defenderData.actionStackIcon = creatureLoaderCmd.creatureImageInfo.icon;
	_defenderData.parentPlayer = player2;
	
	var disEvt:GameEvent = new GameEvent(GameEvent.ADD_BATTLEFIELDITEMDATA);
	disEvt.battleFieldItemData = battleFieldData;
	ES.dispatchEvent(disEvt);
	
	var disEvt1:GameEvent = new GameEvent(GameEvent.ADD_BATTLEFIELDITEMDATA);
	disEvt1.battleFieldItemData = _attackerData;
	ES.dispatchEvent(disEvt1);
	
	var disEvt2:GameEvent = new GameEvent(GameEvent.ADD_BATTLEFIELDITEMDATA);
	disEvt2.battleFieldItemData = _defenderData;
	ES.dispatchEvent(disEvt2);
	
//	this._battleFieldContainer.addBattleFieldItem(_battleFieldItem, 0, 0);
}

protected function attack_clickHandler(event:MouseEvent):void
{
	GS.performAttack(this._attackerData, this._defenderData);
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
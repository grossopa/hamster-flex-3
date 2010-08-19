// ActionScript file
import mx.events.FlexEvent;

import org.hamster.mapleBattle.main.BattleFloorContainer;
import org.hamster.mapleCard.base.constants.Constants;
import org.hamster.mapleCard.base.model.battleField.CreatureBattleFieldItemData;
import org.hamster.mapleCard.base.model.player.Player;
import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;

protected function windowedapplication1_applicationCompleteHandler(event:FlexEvent):void
{
	var player1:Player = new Player();
	player1.direction = "right";
	player1.color = 0xdd0000;
	
	var player2:Player = new Player();
	player2.direction = "left";
	player2.color = 0x0000dd;
	
//	var battleFieldData:CreatureBattleFieldItemData = new CreatureBattleFieldItemData();
//	battleFieldData.id = Constants.CREATE_KEY_PREFIX + "0100100";
//	battleFieldData.maxHp = 10;
//	battleFieldData.hp = 3;
//	battleFieldData.actionProgress = Math.random() * 100;
//	battleFieldData.actionStackIcon = creatureLoaderCmd.creatureImageInfo.icon;
//	battleFieldData.parentPlayer = player1;
	
	var _attackerData:CreatureBattleFieldItemData = new CreatureBattleFieldItemData();
	_attackerData.id = Constants.CREATE_KEY_PREFIX + "0100100";
	CreatureBattleFieldItemData(_attackerData).maxHp = 10;
	_attackerData.hp = 10;
	_attackerData.xIndex = 3;
	_attackerData.yIndex = 3;
	_attackerData.maxAtt = 3;
	_attackerData.maxDef = 1;
	_attackerData.maxDistance = 1;
	_attackerData.maxMoveSpeed = 1;
	_attackerData.moveSpeed = 1;
	_attackerData.actionProgress = Math.random() * 100;
	// _attackerData.actionStackIcon = creatureLoaderCmd.creatureImageInfo.icon;
	_attackerData.parentPlayer = player1;
	
	var _defenderData:CreatureBattleFieldItemData = new CreatureBattleFieldItemData();
	_defenderData.id = Constants.CREATE_KEY_PREFIX + "0100100";
	CreatureBattleFieldItemData(_defenderData).maxHp = 10;
	_defenderData.hp = 10;
	_defenderData.xIndex = 4;
	_defenderData.yIndex = 3;
	_defenderData.maxAtt = 3;
	_defenderData.maxDef = 1;
	_defenderData.maxDistance = 1;
	_defenderData.maxMoveSpeed = 1;
	_defenderData.moveSpeed = 1;
	_defenderData.actionProgress = Math.random() * 100;
//	_defenderData.actionStackIcon = creatureLoaderCmd.creatureImageInfo.icon;
	_defenderData.parentPlayer = player2;
	
	var item1:BattleFieldItem = new BattleFieldItem();
	item1.battleFieldData = _attackerData;
	var item2:BattleFieldItem = new BattleFieldItem();
	item2.battleFieldData = _defenderData;
	
	var bfc:BattleFloorContainer = new BattleFloorContainer();
	sv.addChild(bfc);
	bfc.addBattleFieldItem(item1, 0);
	bfc.addBattleFieldItem(item2, 550);
	
}
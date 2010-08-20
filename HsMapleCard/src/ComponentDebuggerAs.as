// ActionScript file
import mx.events.FlexEvent;

import org.hamster.commands.events.CommandEvent;
import org.hamster.mapleBattle.main.BattleFloorContainer;
import org.hamster.mapleBattle.main.component.buildTile.BuildTileContainer;
import org.hamster.mapleBattle.main.component.buildTile.model.BuildItemVO;
import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
import org.hamster.mapleCard.base.constants.Constants;
import org.hamster.mapleCard.base.model.battleField.CreatureBattleFieldItemData;
import org.hamster.mapleCard.base.model.player.Player;
import org.hamster.mapleCard.base.services.DataService;
import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;
import org.osmf.traits.PlayableTrait;

private static var DS:DataService = DataService.instance;

private var _player1:Player;
private var _player2:Player;
private var _attackerData:CreatureBattleFieldItemData;

public function get player1():Player { return _player1 }
public function get player2():Player { return _player2 }

protected function windowedapplication1_applicationCompleteHandler(event:FlexEvent):void
{
	var creatureLoaderCmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd.execute("0100100");
	creatureLoaderCmd.addEventListener(CommandEvent.COMMAND_RESULT, creatureLoaderResultHandler);
}

private function creatureLoaderResultHandler(evt:CommandEvent):void
{
	var creatureLoaderCmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
	DS.imageCacheManager.put(Constants.CREATE_KEY_PREFIX + creatureLoaderCmd.creatureImageInfo.id, 
		creatureLoaderCmd.creatureImageInfo);
	
	_player1 = new Player();
	_player1.direction = "right";
	_player1.color = 0xdd0000;
	
	_player2 = new Player();
	_player2.direction = "left";
	_player2.color = 0x0000dd;
	
//	var battleFieldData:CreatureBattleFieldItemData = new CreatureBattleFieldItemData();
//	battleFieldData.id = Constants.CREATE_KEY_PREFIX + "0100100";
//	battleFieldData.maxHp = 10;
//	battleFieldData.hp = 3;
//	battleFieldData.actionProgress = Math.random() * 100;
//	battleFieldData.actionStackIcon = creatureLoaderCmd.creatureImageInfo.icon;
//	battleFieldData.parentPlayer = player1;
	
	_attackerData = new CreatureBattleFieldItemData();
	_attackerData.id = Constants.CREATE_KEY_PREFIX + "0100100";
	CreatureBattleFieldItemData(_attackerData).maxHp = 10;
	_attackerData.hp = 10;
	_attackerData.xIndex = 3;
	_attackerData.yIndex = 3;
	_attackerData.maxAtt = 3;
	_attackerData.maxDef = 1;
	_attackerData.maxDistance = 1;
	_attackerData.maxMoveSpeed = 1;
	_attackerData.moveSpeed = 2;
	_attackerData.actionProgress = Math.random() * 100;
	_attackerData.itemIcon = creatureLoaderCmd.creatureImageInfo.icon;
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
	_defenderData.moveSpeed = 2;
	_defenderData.actionProgress = Math.random() * 100;
	_defenderData.itemIcon = creatureLoaderCmd.creatureImageInfo.icon;
	_defenderData.parentPlayer = player2;
	
	var item1:BattleFieldItem = new BattleFieldItem();
	item1.battleFieldData = _attackerData;
	var item2:BattleFieldItem = new BattleFieldItem();
	item2.battleFieldData = _defenderData;
	
	var bfc:BattleFloorContainer = new BattleFloorContainer();
	sv.addChild(bfc);
	bfc.addBattleFieldItem(item1, 0);
	bfc.addBattleFieldItem(item2, 550);
	
	
	createBuildTileItems();
}

private function createBuildTileItems():void
{
	var btc:BuildTileContainer = new BuildTileContainer(player1);
	sv.addChild(btc);
	btc.y = 200;
	var buildItemVO:BuildItemVO = new BuildItemVO(_attackerData);
	buildItemVO.moneyCost = 10;
	btc.tileItemDataList.addItem(buildItemVO);
	
}
// ActionScript file
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

import noorg.magic.commands.impl.init.CreateSchemaCmd;
import noorg.magic.commands.impl.init.InitializeDatabaseCmd;
import noorg.magic.commands.impl.init.LoadConfigureCmd;
import noorg.magic.pojos.DCard;
import noorg.magic.services.HTTPServices;

import org.hamster.commands.impl.CommandQueue;

private const RS:IResourceManager = ResourceManager.getInstance();

private function init():void
{
}

private function appCompleteHandler():void
{
	mainTab.dataProvider = this.mainViewStack;
	
	new HTTPServices();
	var ldCmd:LoadConfigureCmd = new LoadConfigureCmd();
	ldCmd.execute();
}

private function initDatabase():void
{
	var _idCmd:InitializeDatabaseCmd = new InitializeDatabaseCmd();
	var _csCardCmd:CreateSchemaCmd = new CreateSchemaCmd();
	_csCardCmd.pojo = new DCard();
	var cmdQueue:CommandQueue = new CommandQueue([_idCmd, _csCardCmd]);
	cmdQueue.execute();	
}


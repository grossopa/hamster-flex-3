// ActionScript file
import noorg.magic.commands.impl.init.CreateSchemaCmd;
import noorg.magic.commands.impl.init.InitializeDatabaseCmd;
import noorg.magic.commands.impl.init.LoadConfigureCmd;
import noorg.magic.pojos.DCard;
import noorg.magic.services.DataService;
import noorg.magic.services.i18n.ResourceService;

import org.hamster.commands.impl.CommandQueue;

private const RS:ResourceService = ResourceService.getInstance();
private const DS:DataService = DataService.getInstance();

private function localeChanged():void
{
	RS.localeChain = localeComboBox.selectedItem as String;
}

private function initDatabase():void
{
	var _lcCmd:LoadConfigureCmd = new LoadConfigureCmd();
	var _idCmd:InitializeDatabaseCmd = new InitializeDatabaseCmd();
	var _csCardCmd:CreateSchemaCmd = new CreateSchemaCmd();
	_csCardCmd.pojo = new DCard();
	var cmdQueue:CommandQueue = new CommandQueue([_lcCmd, _idCmd, _csCardCmd]);
	cmdQueue.execute();	
}

private function showDetailTipChange():void
{
	DS.isAutoShowCardDetail = this.showCardDetailTipCheckBox.selected;
}
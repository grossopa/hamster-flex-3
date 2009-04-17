
import org.hamster.networks.command.ICommand;
import org.hamster.networks.service.HTTPServiceLocator;
import org.hamster.test.networks.command.GetBaiduCmd;
import org.hamster.test.networks.command.GetGoogleCmd;
import org.hamster.test.networks.service.HTTPServices;

import mx.controls.Alert;
private function appComplete():void
{
	var ddd:HTTPServiceLocator = HTTPServiceLocator.getInstance();
	var dddd:HTTPServices = new HTTPServices();
	var param:Object = new Object();
	param["ran"]  = Math.random();
	
	var baiduCmd:GetBaiduCmd = new GetBaiduCmd();
	baiduCmd.commandResponder = this;
	baiduCmd.execute();
	
	var googleCmd:GetGoogleCmd = new GetGoogleCmd();
	googleCmd.commandResponder = this;
	googleCmd.execute();
}

public function commandResult(cmd:ICommand):void
{
	if (cmd is GetGoogleCmd) {
		Alert.show("google");
	} else if (cmd is GetBaiduCmd) {
		Alert.show("baidu");
	}
}

public function commandFault(cmd:ICommand):void
{
	
}
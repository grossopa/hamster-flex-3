import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.hamster.commands.events.CommandEvent;
import org.hamster.dropbox.Authenticator;
import org.hamster.dropbox.DropboxClient;
import org.hamster.dropbox.DropboxEvent;
import org.hamster.dropbox.commands.DropboxCommand;
import org.hamster.dropbox.models.AccountInfo;
import org.hamster.dropbox.utils.DropboxConstants;

private var auth:Authenticator;
private var client:DropboxClient;

[Bindable] private var accountInfo:AccountInfo;

//a8okqizo1k7u6og
//pf9gtfqloa1braw
//gqutzxa4xvilaiy
//rcweksx39v9xcda

private function loginByPwd():void
{
	var loginCmd:DropboxCommand = client.getToken(emailInput.text, passInput.text);
	loginCmd.addEventListener(CommandEvent.COMMAND_RESULT, function (evt:CommandEvent):void
	{
	});
	loginCmd.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	loginCmd.execute();
}

private function appCompleteHandler():void
{
	var config:Object = new Object();
	config["consumer_key"] = 'wnl0erseogu50mk';
	config["consumer_secret"] = 'eypos93aukcysdw';
//	config['request_token_key'] = 'a8okqizo1k7u6og';
//	config['request_token_secret'] = 'pf9gtfqloa1braw';
//	config['access_token_key'] = 'gqutzxa4xvilaiy';
//	config['access_token_secret'] = 'rcweksx39v9xcda';
	config['server'] = DropboxConstants.SERVER;
	config['content_server'] = DropboxConstants.CONETENT_SERVER;
	config['port'] = DropboxConstants.PORT;
	config["request_token_url"] = DropboxConstants.REQUEST_TOKEN_URL;
	config["access_token_url"] = DropboxConstants.ACCESS_TOKEN_URL;
	config["authorization_url"] = DropboxConstants.AUTHORIZATION_URL;
	auth = new Authenticator(config);
	client = new DropboxClient(config, auth);
}

public function getRequestToken():void
{
	auth.addEventListener(DropboxEvent.REQUEST_TOKEN_RESULT, requestTokenResultHandler);
	auth.addEventListener(DropboxEvent.REQUEST_TOKEN_FAULT, requestTokenFaultHandler);
	auth.retrieveRequestToken();
}

private function requestTokenResultHandler(evt:DropboxEvent):void
{
	requestTokenLabel.text = evt.requestToken.key;
	requestTokenSecretLabel.text = evt.requestToken.secret;
	Alert.show("go to " + auth.getAuthorizeUrl());
}

private function requestTokenFaultHandler(evt:DropboxEvent):void
{
	Alert.show("requestTokenFaultHandler Fault");
}
private function getAccessToken():void
{
	auth.addEventListener(DropboxEvent.ACCESS_TOKEN_RESULT, accessTokenResultHandler);
	auth.addEventListener(DropboxEvent.ACCESS_TOKEN_FAULT, accessTokenFaultHandler);
	auth.retrieveAccessToken();
}

private function accessTokenResultHandler(evt:DropboxEvent):void
{
	accessTokenLabel.text = evt.accessToken.key;
	accessTokenSecretLabel.text = evt.accessToken.secret;
}

private function accessTokenFaultHandler(evt:DropboxEvent):void
{
	
}

public function getAccountInfo():void
{	
	var accountInfoCmd:DropboxCommand = client.accountInfo(true, "");
	accountInfoCmd.addEventListener(CommandEvent.COMMAND_RESULT, function (evt:CommandEvent):void
	{
		accountInfo = AccountInfo(evt.currentTarget.resultObject);
	});
	accountInfoCmd.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	accountInfoCmd.execute();
}

public function postFileopsCopy():void
{
	var fileopsCopyCmd:DropboxCommand = client.fileCopy('id_dsa', 'id_dsa' + new Date().time, "");
	fileopsCopyCmd.addEventListener(CommandEvent.COMMAND_RESULT, function (evt:CommandEvent):void
	{
	});
	fileopsCopyCmd.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	fileopsCopyCmd.execute();	
}

public var testFolderName:String;

public function postCreateFolder():void
{
	testFolderName = 'test' + new Date().time;
	var fileopsCopyCmd:DropboxCommand = client.fileCreateFolder(testFolderName, "");
	fileopsCopyCmd.addEventListener(CommandEvent.COMMAND_RESULT, function (evt:CommandEvent):void
	{
	});
	fileopsCopyCmd.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	fileopsCopyCmd.execute();		
}

public function postDeleteFolder():void
{
	var fileopsCopyCmd:DropboxCommand = client.fileDelete(testFolderName, "");
	fileopsCopyCmd.addEventListener(CommandEvent.COMMAND_RESULT, function (evt:CommandEvent):void
	{
	});
	fileopsCopyCmd.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	fileopsCopyCmd.execute();		
}

public function getFile():void
{
	var fileopsCopyCmd:DropboxCommand = client.getFile("id_dsa");
	fileopsCopyCmd.addEventListener(CommandEvent.COMMAND_RESULT, function (evt:CommandEvent):void
	{
	});
	fileopsCopyCmd.addEventListener(CommandEvent.COMMAND_FAULT, faultHandler);
	fileopsCopyCmd.execute();		
}


private function faultHandler(evt:CommandEvent):void
{
	Alert.show(evt.toString());
}
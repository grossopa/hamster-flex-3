import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.hamster.dropbox.Authenticator;
import org.hamster.dropbox.DropboxClient;
import org.hamster.dropbox.DropboxEvent;
import org.hamster.dropbox.util.DropboxConstants;

private var auth:Authenticator;
private var client:DropboxClient;

//a8okqizo1k7u6og
//pf9gtfqloa1braw
//gqutzxa4xvilaiy
//rcweksx39v9xcda

private function appCompleteHandler():void
{
	var config:Object = new Object();
	config["consumer_key"] = 'wnl0erseogu50mk';
	config["consumer_secret"] = 'eypos93aukcysdw';
	config['request_token_key'] = 'a8okqizo1k7u6og';
	config['request_token_secret'] = 'pf9gtfqloa1braw';
	config['access_token_key'] = 'gqutzxa4xvilaiy';
	config['access_token_secret'] = 'rcweksx39v9xcda';
	config['server'] = DropboxConstants.SERVER;
	config['content-server'] = DropboxConstants.CONETENT_SERVER;
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
	client.addEventListener(DropboxEvent.HTTP_RESULT, function (evt:DropboxEvent):void
	{
		Alert.show(ResultEvent(evt.relatedEvent).result.toString());
	});
	
	
	client.addEventListener(DropboxEvent.HTTP_FAULT, function (evt:DropboxEvent):void
	{
		Alert.show(FaultEvent(evt.relatedEvent).fault.toString());
	});
	
	client.accountInfo(true, "");
}
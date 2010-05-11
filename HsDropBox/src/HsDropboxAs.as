import mx.controls.Alert;

import org.hamster.dropbox.Authenticator;
import org.hamster.dropbox.util.DropboxConstants;
import org.hamster.dropbox.DropboxEvent;

private var auth:Authenticator;

private function appCompleteHandler():void
{
	var config:Object = new Object();
	config["consumer_key"] = 'wnl0erseogu50mk';
	config["consumer_secret"] = 'eypos93aukcysdw';
	config["request_token_url"] = DropboxConstants.REQUEST_TOKEN_URL;
	config["access_token_url"] = DropboxConstants.ACCESS_TOKEN_URL;
	config["authorization_url"] = DropboxConstants.AUTHORIZATION_URL;
	auth = new Authenticator(config);
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
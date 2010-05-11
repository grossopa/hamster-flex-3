package org.hamster.dropbox
{
	import flash.events.EventDispatcher;
	
	import mx.rpc.http.HTTPService;

	/**
	* The DropboxClient is the core of the Java API, and is designed to be both instructive and
	* easy to use.  If you find yourself needing to do more than what's provided, use the code here
	* as a guide to implement your own alternatives.
	*
	* Before you can work with DropboxClient you'll need to configure an Authenticator with a
	* working OAuth access token.  Typically this is done like this:
	*
	* <pre>
	*  Map config = Authenticator.loadConfig("config/testing.json");
	*  Authenticator auth = new Authenticator(config);
	*  String url = auth.retrieveRequestToken("http://mysite.com/theyaredone?blah=blah");
	*  // bounce them to the URL
	*  auth.retrieveAccessToken("");
	*  String access_key = auth.getTokenKey();
	*  String access_secret = auth.getTokenSecret();
	*  // store those so that you can put them in config and not have to do the above again
	* </pre>
	*
	* Once you've done the above, or configured a config Map with "access_token_key" and 
	* "access_token_secret" parameters, then you can create a DropboxClient object to work with:
	*
	* <pre>
	*  DropboxClient client = new DropboxClient(config, auth);
	* </pre>
	*
	* And that should be it.  For every operation you need to catch the DropboxException, but that's
	* the only additional complexity.
	*/
	public class DropboxClient extends DropboxClientSupport
	{
		public var auth:Authenticator;
		public var api_host:String = null;
		public var content_host:String = null;
		public var port:int = 80;
		
		/**
		 * Config needs to have settings for "server", "content_server", and "port" (which should be a Long),
		 * and auth should be ready to work with an access key.
		 */
		public function DropboxClient(config:Object, auth:Authenticator)
		{
			super();
			
			this.auth = auth;
			this.api_host = config['server'];
			this.content_host = config['content_server'];
			this.port = config['port'];
		}
		
		/**
		 * The account/info API call to Dropbox for getting info about an account attached to the access token.
		 */
		public function accountInfo(status_in_response:Boolean, callback:String):void
		{
			var params:Object = {
				"status_in_response", status_in_response,
				"callback", callback
			};
			
			request("GET", defaultProtocol, api_host, port, "/account/info", API_VERSION, params, auth);
		}
		
		/**
		 * Copy a file from one path to another, with root being either "sandbox" or "dropbox".
		 */
		public function fileCopy(root:String, from_path:String, to_path:String, callback:String):Object
		{
			var params:Object = { "root", root, "from_path", from_path,
				"to_path", to_path, "callback", callback };
			
			return request("POST", defaultProtocol, api_host, port, "/fileops/copy", API_VERSION, params, auth);
		}
		
		/** Create a folder at the given path. */
		public function fileCreateFolder(root:String, path:String, callback:String):Object
		{
			var params:Object = { "root", root, "path", path, "callback", callback };
			
			return request("POST", defaultProtocol, api_host, port, "/fileops/create_folder", API_VERSION, params, auth);
		}
		
		/** Delete a file. */
		public function fileDelete(root:String, String path, String callback):Object
		{
			var params:Object = { "root", root, "path", path, "callback", callback };
			return request("POST", defaultProtocol, api_host, port, "/fileops/delete", API_VERSION, params, auth);
		}
		
		/** Move a file. */
		public function fileMove(root:String, from_path:String, to_path:String, callback:String):Object
		{
			var params:Object = { "root", root, "from_path", from_path,
				"to_path", to_path, "callback", callback };
			
			return request("POST", defaultProtocol, api_host, port, "/fileops/move", API_VERSION, params, auth);
		}
		
		/**
		 * Get a file from the content server, returning the raw Apache HTTP Components response object
		 * so you can stream it or work with it how you need. 
		 * You *must* call .getEntity().consumeContent() on the returned HttpResponse object or you might leak 
		 * connections.
		 */
		public function getFile(root:String, String from_path):HTTPService
		{
			return getFileWithVersion(root, from_path, null);
		}
		
		/**
		 * Get a file from the content server, returning the raw Apache HTTP Components response object
		 * so you can stream it or work with it how you need. 
		 * You *must* call .getEntity().consumeContent() on the returned HttpResponse object or you might leak 
		 * connections.
		 */
		public function getFileWithVersion(root:String, String from_path, String etag):HTTPService
		{
//			path:String = "/files/" + root + from_path;
//			HttpClient client = getClient();
//			
//			try {
//				String target = buildFullURL(secureProtocol, content_host, port, buildURL(path, API_VERSION, null));
//				HttpGet req = new HttpGet(target);
//				if (etag != null) {
//					req.addHeader("If-None-Match", etag);
//				}
//				auth.sign(req);
//				return client.execute(req);
//			} catch(Exception e) {
//				throw new DropboxException(e);
//			}
		}
		
		/**
		 * Does not actually talk to Dropbox, but instead crafts a properly formatted URL that you can
		 * put into your UI which will link a user to that file in their own account.  They will need
		 * to login to their Dropbox account on the website to access the file.
		 */
		public function links(root:String, path:String):String
		{
			String url_path = "/links/" + root + path;
			
			return buildFullURL(defaultProtocol, api_host, port, buildURL(url_path, API_VERSION, null));
		}
		
		
		/**
		 * Get metadata about directories and files, such as file listings and such.
		 */
		public function metadata(root:String, 
								 path:String, 
								 file_limit:int, 
								 hash:String, 
								 list:Boolean, 
								 status_in_response:Boolean, callback:String):Object
		{
			var params:Object = {
				"file_limit", "" + file_limit,
				"hash", hash,
				"list", "" + list,
				"status_in_response", "" + status_in_response,
				"callback", callback };
			
			var url_path:String = "/files/" + root + path;
			
			return request("GET", defaultProtocol, api_host, port, url_path, API_VERSION, params, auth);
		}
		
		
		public function eventMetadata(root:String, target_events:Object):Object
		{
			//String jsonText = JSONValue.toJSONString(target_events);
			var jsonText:String = target_events.toString();
			var params:Object = {
				"root", root,
				"target_events", jsonText,
			};
			
			return request("POST", defaultProtocol, api_host, port, "/event_metadata", API_VERSION, params, auth);
		}
		
		/**
		 * You *must* call .getEntity().consumeContent() on the returned HttpResponse object or you might leak 
		 * connections.
		 */
		public function eventContent(root:String, user_id:int, namespace_id:int, journal_id:int):HTTPService
		{
			var path:String = "/event_content";
			//HttpClient client = getClient();
			var params:Object = {
				"root", root,
				"target_event", "" + user_id + ":" + namespace_id + ":" + journal_id 
			};
			
			String target = buildFullURL(defaultProtocol, content_host, this.port, buildURL(path, API_VERSION, params));
			HttpGet req = new HttpGet(target);
			auth.sign(req);
			return client.execute(req);
		}
		
		public boolean eventContentAvailable(Map md) {
			return md.get("error") == null && 
				((Boolean)md.get("latest")).booleanValue() == true && 
				((Integer)md.get("size")).intValue() != -1 && 
				((Boolean)md.get("is_dir")).booleanValue() == false;
		}
		
		/**
		 * Put a file in the user's Dropbox.
		 */
		public HttpResponse putFile(root:String, to_path:String, File file_obj) throws DropboxException
		{
			path:String = "/files/" + root + to_path;
			
			HttpClient client = getClient();
			
			try {
				String target = buildFullURL(secureProtocol, content_host, this.port, buildURL(path, API_VERSION, null));
				HttpPost req = new HttpPost(target);
				// this has to be done this way because of how oauth signs params
				// first we add a "fake" param of file=path of *uploaded* file
				// THEN we sign that.
				List nvps = new ArrayList();
				nvps.add(new BasicNameValuePair("file", file_obj.getName()));
				req.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
				auth.sign(req);
				
				// now we can add the real file multipart and we're good
				MultipartEntity entity = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE);
				FileBody bin = new FileBody(file_obj);
				entity.addPart("file", bin);
				// this resets it to the new entity with the real file
				req.setEntity(entity);
				
				HttpResponse resp = client.execute(req);
				
				resp.getEntity().consumeContent();
				return resp;
			} catch(Exception e) {
				throw new DropboxException(e);
			}
		}
		
	}
}
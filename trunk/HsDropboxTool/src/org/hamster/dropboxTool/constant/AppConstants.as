package org.hamster.dropboxTool.constant
{
	import org.hamster.dropbox.DropboxEvent;

	public class AppConstants
	{
		// command-related events
		public static const APP_INIT_REQUEST:String = "AppInitRequest";
		
		public static const CONFIGURATION_LOAD_REQUEST:String 				= "hsConfigurationLoadRequest";
		public static const CONFIGURATION_LOAD_RESULT:String 				= "hsConfigurationLoadResult";
		public static const CONFIGURATION_LOAD_FAULT:String 				= "hsConfigurationLoadFault";
		public static const CONFIGURATION_SAVE_REQUEST:String 				= "hsConfigurationSaveRequest";
		public static const CONFIGURATION_SAVE_RESULT:String 				= "hsConfigurationSaveResult";
		
		public static const LINE_SEP_N:String = "\n";
		public static const LINE_SEP_RN:String = "\r\n";
		
		public static const REQUEST_TOKEN_REQUEST:String    = "hsRequestTokenRequest";
		public static const REQUEST_TOKEN_RESULT:String 	= DropboxEvent.REQUEST_TOKEN_RESULT;
		public static const REQUEST_TOKEN_FAULT:String 		= DropboxEvent.REQUEST_TOKEN_FAULT;
		public static const ACCESS_TOKEN_REQUEST:String     = "hsAccessTokenRequest";
		public static const ACCESS_TOKEN_RESULT:String 		= DropboxEvent.ACCESS_TOKEN_RESULT;
		public static const ACCESS_TOKEN_FAULT:String 		= DropboxEvent.ACCESS_TOKEN_FAULT;
		
		public static const SHOW_FILE_LIST_VIEW:String		= "hsShowFileListView";
	}
}
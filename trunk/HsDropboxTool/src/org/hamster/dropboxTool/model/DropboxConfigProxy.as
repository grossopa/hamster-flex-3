package org.hamster.dropboxTool.model
{
	import org.hamster.dropbox.DropboxConfig;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class DropboxConfigProxy extends Proxy
	{
		public static const NAME:String = "DropboxConfigProxy";
		
		public var dropboxConfig:DropboxConfig;
		
		public function DropboxConfigProxy(data:Object=null)
		{
			super(NAME, data);
		}
	}
}
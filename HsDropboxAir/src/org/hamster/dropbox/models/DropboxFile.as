package org.hamster.dropbox.models
{
// {"thumb_exists": false,
//	"bytes": 736, 
//	"modified": "Wed, 12 May 2010 07:28:39 +0000", 
//	"path": "/id_dsa1273649318857", 
//	"is_dir": false, 
//	"icon": "page_white", 
//	"root": "sandbox", 
//	"mime_type": "application/octet-stream",
//	"size": "736 bytes"}
	public class DropboxFile extends DropboxModelSupport
	{
		public var thumbExists:Boolean;
		public var bytes:Number;
		public var modified:Date;
		public var isDir:Boolean;
		public var icon:String;
		public var root:String;
		public var mimeType:String;
		public var size:String;
		
		public var hash:String;
		public var contents:Array;
		
		public function DropboxFile()
		{
		}
		
		override public function decode(result:Object):void
		{
			super.decode(result);
			
			this.thumbExists = String(result['thumb_exists']) == 'true';
			this.bytes = result['bytes'];
			this.modified = new Date(result['modified']);
			this.isDir = String(result['is_dir']) == 'true';
			this.icon = result['icon'];
			this.root = result['root'];
			this.mimeType = result['mime_type'];
			this.size = result['size'];
			
			this.hash = result['hash'];
			
			this.contents = new Array();
			for each (var content:Object in result['contents']) {
				var subFile:DropboxFile = new DropboxFile();
				subFile.decode(content);
				this.contents.push(subFile);
			}
		}
	}
}
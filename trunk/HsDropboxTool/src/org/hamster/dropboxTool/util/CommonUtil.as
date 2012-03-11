package org.hamster.dropboxTool.util
{
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.symmetric.ICipher;
	import com.hurlant.crypto.symmetric.IPad;
	import com.hurlant.crypto.symmetric.IVMode;
	import com.hurlant.crypto.symmetric.PKCS5;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	public class CommonUtil
	{
		/**
		 * a wrapper to popup a window.
		 * 
		 * @param className
		 * @param parent
		 * @return 
		 * 
		 */
		public static function popup(className:Class, parent:DisplayObject):IFlexDisplayObject
		{
			var result:IFlexDisplayObject = PopUpManager.createPopUp(parent, className, true);
			PopUpManager.centerPopUp(result);
			return result;
		}
		
		public static function removePopUp(target:IFlexDisplayObject):void
		{
			PopUpManager.removePopUp(target);
		}
		
		public static function correctDropboxPath(path:String):String
		{
			return path.indexOf('/') == 0 ? path.substr(1) : path;
		}
		
		public static function encrypt(txt:String):Array
		{
			// 2: get a key
			var k:String = "a13a01a20bbc45b6330d7f54f4c3911a3bef680d1ecfb114";
			var kdata:ByteArray;
			var kformat:String = "hex";
			switch (kformat) {
				case "hex": kdata = Hex.toArray(k); break;
				case "b64": kdata = Base64.decodeToByteArray(k); break;
				default:
					kdata = Hex.toArray(Hex.fromString(k));
			}
			// 3: get an input
			var data:ByteArray;
			var format:String = "hex1";
			switch (format) {
				case "hex": data = Hex.toArray(txt); break;
				case "b64": data = Base64.decodeToByteArray(txt); break;
				default:
					data = Hex.toArray(Hex.fromString(txt));
			}
			// 1: get an algorithm..
			var name:String = "des3";
			var pad:IPad = new PKCS5();
			var mode:ICipher = Crypto.getCipher(name, kdata, pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.encrypt(data);
			
			if (mode is IVMode) {
				var ivmode:IVMode = mode as IVMode;
				var vector:String = Hex.fromArray(ivmode.IV);
			}
			
			return [data.readUTFBytes(data.bytesAvailable) ,vector];
		}
		
		public static function decrypt(txtArr:Array):String
		{
			// 2: get a key
			var k:String = "a13a01a20bbc45b6330d7f54f4c3911a3bef680d1ecfb114";
			var kdata:ByteArray;
			var kformat:String = "hex";
			var txt:String = txtArr[0];
			switch (kformat) {
				case "hex": kdata = Hex.toArray(k); break;
				case "b64": kdata = Base64.decodeToByteArray(k); break;
				default:
					kdata = Hex.toArray(Hex.fromString(k));
			}
			// 3: get an output
			var data:ByteArray;
			var format:String = "hex1";
			switch (format) {
				case "hex": data = Hex.toArray(txt); break;
				case "b64": data = Base64.decodeToByteArray(txt); break;
				default:
					data = Hex.toArray(Hex.fromString(txt));
			}
			// 1: get an algorithm..
			var name:String = "des3";
			
			var pad:IPad = new PKCS5();
			var mode:ICipher = Crypto.getCipher(name, kdata, pad);
			pad.setBlockSize(mode.getBlockSize());
			// if an IV is there, set it.
			if (mode is IVMode) {
				var ivmode:IVMode = mode as IVMode;
				ivmode.IV = Hex.toArray(txtArr[1]);
			}
			mode.decrypt(data);
			return data.readUTFBytes(data.bytesAvailable);
		}
		
	}
}
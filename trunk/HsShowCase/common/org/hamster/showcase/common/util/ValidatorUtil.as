package org.hamster.showcase.common.util
{
	public class ValidatorUtil
	{
		public function ValidatorUtil()
		{
		}
		
		public static function remoteRequest(xml:XML):int
		{
			var status:String = xml.attribute("status");
			if (status == null || status.length == 0) {
				return -1;
			} else {
				return parseInt(status);
			}
		}
	}
}
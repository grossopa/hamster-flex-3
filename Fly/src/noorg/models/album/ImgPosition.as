package noorg.models.album
{
	public class ImgPosition
	{
		public function ImgPosition(xml:XML = null)
		{
			if (xml != null) {
				init(xml);
			}
		}
		
		public function init(xml:XML):void
		{
			this.percentX = xml.attribute("percent-x");
			this.percentY = xml.attribute("percent-y");
			this.percentWidth = xml.attribute("percent-width");
			this.percentHeight = xml.attribute("percent-height");			
		}
		
		/**
		 * percent, from 0 ~ 1
		 */
		public var percentX:Number;
		/**
		 * percent, from 0 ~ 1
		 */
		public var percentY:Number;
		/**
		 * percent, from 0 ~ 1
		 */
		public var percentWidth:Number;
		/**
		 * percent, from 0 ~ 1
		 */
		public var percentHeight:Number;

	}
}
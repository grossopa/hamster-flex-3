package noorg.models.album
{
	import mx.collections.ArrayCollection;
	
	public class PageStyle
	{
		private var _xml:XML;
		
		public function get xml():XML
		{
			return this._xml;
		}
		
		/**
		 * Array of ImageData
		 */
		public var imageDatas:ArrayCollection = new ArrayCollection();
		public var imgPositions:ArrayCollection = new ArrayCollection();
		
		public var bgImg:BackgroundImage;
		public var ratio:Number;
		
		public function get name():String
		{
			// TODO:
			return "";
		}
		
		/**
		 * class for page style, currently disabled
		 */
		private var className:String;
		
		public function PageStyle(xml:XML = null)
		{
			if (xml != null) {
				this.init(xml);
			}
		}
		
		public function init(xml:XML):void
		{
			this._xml = xml;
			var r:Array = String(xml.attribute("ratio")).split(":");
			this.ratio = parseFloat(r[0]) / parseFloat(r[1]);
			
			for each (var xmlChild:XML in xml.children()) {
				if (xmlChild.name().toString() == "img-position") {
					this.imgPositions.addItem(new ImgPosition(xmlChild));
				}
			}			
		}
		
		public function clone():PageStyle
		{
			var result:PageStyle = new PageStyle(this.xml.copy());
			
			if (this.bgImg != null) {
				result.bgImg = this.bgImg.clone();
			}
			return result;
		}
	}
}
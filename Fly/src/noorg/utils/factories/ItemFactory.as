package noorg.utils.factories
{
	import noorg.controls.management.units.SelBgImgUnit;
	import noorg.controls.management.units.SelImgPosUnit;
	import noorg.models.album.BackgroundImage;
	import noorg.models.album.PageStyle;
	import noorg.services.DataService;
	
	public class ItemFactory
	{
		private static const DS:DataService = DataService.getInstance();
		
		public function ItemFactory()
		{
		}
		
		public static function createSelBgImgUnit(bgImg:BackgroundImage):SelBgImgUnit
		{
			var result:SelBgImgUnit = new SelBgImgUnit();
			//result.width = 100;
			//result.height = 100 / DS.ratio;
			result.bgImg = bgImg;
			return result;
		}
		
		public static function createSelImgPosUnit(pageStyle:PageStyle):SelImgPosUnit
		{
			var result:SelImgPosUnit = new SelImgPosUnit();
			//result.width = 100;
			//result.height = 100 / DS.ratio;
			result.pageStyle = pageStyle;
			return result;
		}

	}
}
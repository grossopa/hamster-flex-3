package noorg.utils.factories
{
	import flash.filesystem.File;
	
	import noorg.models.album.ImageData;
	import noorg.models.album.ImgPosition;
	
	public class ModelObjFactory
	{
		public static function createImageDataByFile(file:File):ImageData
		{
			var result:ImageData = new ImageData();
			result.file = file;
			return result;
		}

	}
}
package org.hamster.showcase.imageCropper.vo
{
	import org.hamster.showcase.common.vo.BaseVO;
	
	public class CropImageVO extends BaseVO
	{
		public var id:String;
		public var name:String;
		public var location:String;
		public var width:Number;
		public var height:Number;
		
		public function CropImageVO()
		{
			super();
		}
	}
}
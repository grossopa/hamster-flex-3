package org.hamster.mapleCard.base.model.support
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class CreatureImageInfo
	{
		public var uid:String;
		
		public var icon:Bitmap;
		public var moveImages:Array = [];
		public var standImages:Array = [];
		public var hitImages:Array = [];
		public var dieImages:Array = [];
	}
}
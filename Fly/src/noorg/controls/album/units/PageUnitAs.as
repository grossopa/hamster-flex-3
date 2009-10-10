// ActionScript file
import noorg.controls.album.units.ImageUnit;
import noorg.models.album.BackgroundImage;
import noorg.models.album.ImgPosition;
import noorg.models.album.PageStyle;

public var pageStyle:PageStyle;
public var selected:Boolean = false;

public function get ratio():Number
{
	return pageStyle.ratio;
}

protected function completeHandler():void
{
	if (this.pageStyle != null) {
		this.validatePageStyle();
	} else {
		this.pageStyle = new PageStyle();	
	}
}

public function validatePageStyle():void
{
	imageUnitContainer.removeAllChildren();
	
	if (pageStyle.bgImg != null) {
		validateBgImg();
	}
	
	for each (var imgPosition:ImgPosition in pageStyle.imgPositions) {
		var imageUnit:ImageUnit = new ImageUnit();
		imageUnit.imgPosition = imgPosition;
		this.imageUnitContainer.addChild(imageUnit);
	}
}

public function validateBgImg():void
{
	this.backgroundImage.source = pageStyle.bgImg.source;
}

private function resizeHandler():void
{
	if (this.imageUnitContainer != null) {
		for each (var imageUnit:ImageUnit in this.imageUnitContainer) {
			imageUnit.validateImgPosition();
		}
	}
}
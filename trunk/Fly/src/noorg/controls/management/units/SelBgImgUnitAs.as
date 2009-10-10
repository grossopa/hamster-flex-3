// ActionScript file
import noorg.models.album.BackgroundImage;

public var bgImg:BackgroundImage;

override protected function completeHandler():void
{
	super.completeHandler();
	
	this.imageUnitContainer.visible = false;
	
	if (this.bgImg != null) {
		this.pageStyle.bgImg = this.bgImg;
		this.validateBgImg();
	}
}
// ActionScript file
import noorg.controls.album.units.ImageUnit;

override public function validatePageStyle():void
{
	super.validatePageStyle();
	
	this.backgroundImage.visible = false;
	for each (var imgUnit:ImageUnit in this.imageUnitContainer.getChildren()) {
		imgUnit.setStyle("backgroundColor", 0x777777);
		imgUnit.setStyle("borderStyle", "solid");
		imgUnit.setStyle("borderColor", 0xbbbbbb);
		imgUnit.setStyle("borderThickness", 2);
		imgUnit.validateImgPosition();
	}
}
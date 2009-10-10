// ActionScript file
import noorg.models.album.ImageData;
import noorg.models.album.ImgPosition;

private var _imgPosition:ImgPosition;
private var _imageData:ImageData;

public function set imageData(value:ImageData):void
{
	this._imageData = value;
	if (this.initialized) {
		this.validateImagedata();
	}	
}

public function get imageData():ImageData
{
	return this._imageData;
}

public function set imgPosition(value:ImgPosition):void
{
	this._imgPosition = value;
}

public function get imgPosition():ImgPosition
{
	return this._imgPosition;
}

private function completeHandler():void
{
	validateImgPosition();
}

public function validateImgPosition():void
{
	if (this.parent != null) {
		this.x = imgPosition.percentX * this.parent.width;
		this.y = imgPosition.percentY * this.parent.height;
		this.width = imgPosition.percentWidth * this.parent.width;
		this.height = imgPosition.percentHeight * this.parent.height;
	}
}

public function validateImagedata():void
{
	if (this.parent != null) {
		this.mainImage.source = imageData.file.data;
	}
}
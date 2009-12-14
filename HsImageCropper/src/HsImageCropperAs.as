// ActionScript file
import flash.geom.Rectangle;

import mx.controls.Alert;


[Embed(source='/org/hamster/assets/test.jpg')]
private var _test_jpg:Class;

private function completeHandler():void
{
	cropper.setImageData(_test_jpg, 1400, 1050);
}

private function showRect():void
{
	var obj:Rectangle = cropper.getCropArea();
	Alert.show(obj.toString());
}
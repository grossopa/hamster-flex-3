// ActionScript file
import org.hamster.gamesaver.utils.GlobalUtil;

public static const SUCCESS:String = "success";
public static const FAILED:String = "failed";

[Bindable]
public var title:String;

[Bindable]
public var message:String;

[Bindable]
public var stringColor:Number = 0xFFFFFF;

public function set status(value:String):void
{
	if (value == SUCCESS) {
		stringColor = 0xFFFFFF;
	} else if (value == FAILED) {
		stringColor = 0xFF4F4F;
	}
}

private function closeHandler():void
{
	GlobalUtil.removeAlert();
}
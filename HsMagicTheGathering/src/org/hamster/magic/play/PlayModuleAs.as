// ActionScript file
import org.hamster.magic.common.models.Magic;

private function completeHandler():void
{
	var magic:Magic = new Magic();
	magic.red = 3;
	magic.blue = 2;
	magic.green = 0;
	magic.black = 4;
	magic.white = 5;
	magic.colorless = 18;
	testMagicUnit.magic = magic;
}
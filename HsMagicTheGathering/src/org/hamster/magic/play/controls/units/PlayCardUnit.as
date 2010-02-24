package org.hamster.magic.play.controls.units
{
	import mx.core.mx_internal;
	
	import org.hamster.magic.common.controls.units.CardUnit;
	import org.hamster.magic.common.utils.Constants;
	
	use namespace mx_internal;

	public class PlayCardUnit extends CardUnit
	{
		public function PlayCardUnit()
		{
			super();
			this.width = Constants.PLAY_CARD_WIDTH;
			this.height = Constants.PLAY_CARD_HEIGHT;
		}
		
	}
}
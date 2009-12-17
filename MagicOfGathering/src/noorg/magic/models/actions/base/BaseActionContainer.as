package noorg.magic.models.actions.base
{
	import mx.containers.Canvas;

	public class BaseActionContainer extends Canvas
	{
		private var _card:PlayCard;
		
		public function BaseActionContainer()
		{
			super();
		}
		
		public function set card(value:PlayCard):void
		{
			this._card = value;
		}
		
		public function get card():PlayCard
		{
			return this._card;
		}

		
	}
}
package noorg.magic.models
{
	import noorg.magic.events.PlayCardEvent;
	
	public class PlayCard extends Card
	{
		private var _location:int;
		private var _status:int;
		
		public function set location(value:int):void
		{
			var locationEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.LOCATION_CHANGED);
			locationEvt.originLocation = this.location;
			_location = value;
			locationEvt.newLocation = this.location;
			this.dispatchEvent(locationEvt);
		}
		
		[Bindable]
		public function get location():int
		{
			return _location;
		}
		
		public function set status(value:int):void
		{
			var statusEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.STATUS_CHANGED);
			statusEvt.originStatus = this.status;
			_status = value;
			statusEvt.newStatus = this.status;
			this.dispatchEvent(statusEvt);
		}
		
		[Bindable]
		public function get status():int
		{
			return _status;
		}
		
		public function PlayCard()
		{
			super();
		}
		
		

		
	}
}
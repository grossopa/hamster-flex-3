package org.hamster.magic.configure.controls.unit
{
	import mx.controls.NumericStepper;
	import mx.events.NumericStepperEvent;
	
	import org.hamster.magic.common.controls.units.CardUnit;
	import org.hamster.magic.common.models.Card;

	public class SelectedCardUnit extends CardUnit
	{
		protected var _numStepper:NumericStepper;
		
		override public function set card(value:Card):void
		{
			super.card = value;
			
			if (this.initialized) {
				this._numStepper.value = this.card.count;
			}
		}
		
		public function SelectedCardUnit()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_numStepper = new NumericStepper();
			if (this.card != null) {
				_numStepper.value = this.card.count;
			}
			_numStepper.stepSize = 1;
			_numStepper.minimum = 0;
			_numStepper.maximum = 5;
			_numStepper.percentWidth = 100;
			_numStepper.height = 20;
			_numStepper.setStyle("bottom", 0);
			_numStepper.addEventListener(NumericStepperEvent.CHANGE, countChangeHandler);
			this.addChild(_numStepper);
		}
		
		private function countChangeHandler(evt:NumericStepperEvent):void
		{
			this.card.count = _numStepper.value;
		}
		
	}
}
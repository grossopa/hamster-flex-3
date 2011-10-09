import mx.events.FlexEvent;

import org.hamster.enterprise.controls.HsCurrencyTextInput;

protected function vbox1_creationCompleteHandler(event:FlexEvent):void
{
	HsCurrencyTextInput.globalCurrFormatter = this.globalCurrencyFormatter;
}

protected function privateCurrencyFormatterCheckBox_changeHandler(event:Event):void
{
	if (this.privateCurrencyFormatterCheckBox.selected) {
		this.hsCurrencyTextInput.currencyFormatter = this.privateCurrencyFormatter;
	} else {
		this.hsCurrencyTextInput.currencyFormatter = null;
	}
}
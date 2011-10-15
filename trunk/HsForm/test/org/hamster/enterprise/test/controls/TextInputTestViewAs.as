import mx.events.FlexEvent;

import org.hamster.enterprise.controls.HsCurrencyTextInput;
import org.hamster.enterprise.controls.HsTextInput;

[Bindable] private var _currentTextInput:HsTextInput;

protected function vbox1_creationCompleteHandler(event:FlexEvent):void
{
	HsCurrencyTextInput.globalCurrFormatter = this.globalCurrencyFormatter;
	_currentTextInput = hsTextInput;
}

protected function mainViewStack_changeHandler(event:IndexChangedEvent):void
{
	_currentTextInput = this.mainViewStack.selectedChild.getChildAt(1) as HsTextInput;
}

protected function privateCurrencyFormatterCheckBox_changeHandler(event:Event):void
{
	if (this.privateCurrencyFormatterCheckBox.selected) {
		this.hsCurrencyTextInput.currencyFormatter = this.privateCurrencyFormatter;
	} else {
		this.hsCurrencyTextInput.currencyFormatter = null;
	}
}